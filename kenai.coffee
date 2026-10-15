
import path from 'node:path'

import fs from 'node:fs'
import { execSync } from 'node:child_process'

startTime = performance.now()

if process.argv.length < 4
  console.log "Please provide a project name and an app name."
  console.log "For example: kenai myproject app"
  process.exit 1

projectName = process.argv[2]
appName = process.argv[3]

# either argue 'loudly' to print or 'silently' to not print.
# You can also just omit this argument to run it silently.
if process.argv.length >= 5
  toPrintOrNotToPrint = process.argv[4]

rootName = projectName + "_root"

maybePrint = (message)->
  if toPrintOrNotToPrint == "loudly"
    console.log message

execSync "django-admin startproject #{projectName} #{rootName}"
maybePrint "Finished Django scaffolding; beginning Kenai's scaffolding.\n"

appDir = path.join rootName, appName

fs.mkdirSync appDir
maybePrint "Created #{appDir} directory."

appViewBoilerplate = """
from django.shortcuts import render

def index(request):
    return render(request, '#{appDir}/index.html')
"""
fs.writeFileSync path.join(appDir, "views.py"), appViewBoilerplate
maybePrint "Created #{appDir}/views.py"

appUrlBoilerplate = """
from django.urls import path, include

urlpatterns = [
    path('', include('#{appDir}.urls')),
]
"""
fs.writeFileSync path.join(appDir, "urls.py"), appUrlBoilerplate
maybePrint "Created #{appDir}/urls.py"

templatesDir = path.join appDir, "templates"

fs.mkdirSync templatesDir
maybePrint "Created #{templatesDir} directory."

fs.mkdirSync path.join(templatesDir, appName)
maybePrint "Created #{path.join(templatesDir, appName)} directory."

indexHtmlBoilerplate = """
<!DOCTYPE html>
<html lang='en'>
<body>
    <h1>Hei from Kenai!</h1>
</body>
</html>
"""
fs.writeFileSync path.join(templatesDir, appName, "index.html"), indexHtmlBoilerplate
maybePrint "Created #{path.join(templatesDir, appName, "index.html")}"

clickmeText = """
Hey! Django is pretty confusing, so this is a guide on what Kenai just did.

First, you've got #{rootName}. This is going to host everything you'll ever do with this Django app.

Inside of that, there's #{appName} and #{projectName}.
manage.py is there too but I won't be going over that. If you wish, you can read about it here:
https://docs.djangoproject.com/en/6.1/ref/django-admin/

#{projectName} has got all the Django internals.

#{appName} is one of many apps you'll likely use in this project.
Here's a rundown on what apps are:
https://docs.djangoproject.com/en/6.1/ref/applications/

To save you the trouble of navigating Django's website to find what you need,
here's a collection of some things you might need help with.

Here's the link to the general Django docs:
https://docs.djangoproject.com/en/6.1/

Templates:
https://docs.djangoproject.com/en/6.1/ref/templates/language/#templates

A basic rundown of views:
https://docs.djangoproject.com/en/6.1/topics/http/views/

Models:
https://docs.djangoproject.com/en/6.1/topics/db/models/

And here's a page that has links to some other common things:
https://docs.djangoproject.com/en/6.1/topics/

"""

fs.writeFileSync path.join(rootName, "clickme_kenai.txt"), clickmeText

green = (string) -> "\x1b[32m#{string}\x1b[0m"

endTime = performance.now()

durationInSeconds = ((endTime - startTime) / 1000).toFixed(2)

console.log "\n" if toPrintOrNotToPrint == "loudly" # get some blank space for the conclusion message
console.log "This app was scaffolded in #{durationInSeconds} seconds."
console.log green("Done! Cheers, broseph.")

console.log "\nNote: in #{projectName}/settings.py, you'll need to add #{appName} to INSTALLED_APPS."
console.log "I'm sorry that Kenai cannot do that for you."

console.log "\nIf you're unsure where to start, you can check out clickme_kenai.txt for more information."
console.log 'If you don\'t want that, just run rm #{path.join(rootName, "clickme_kenai.txt")'

