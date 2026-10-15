# Kenai

Unlike Ruby on Rails, Django lacks a default scaffolder. This is problematic because when you just want to get to work in your app, you have to look up "How to structure a django app" instead of actually writing code.

Kenai steps in and does the thinking so you don't have to. Zero configuration is necessary, and all you have to tell it is your project name and first app name. For example:

```
node kenai.js project app
```

You can also pass in a third argument to print the name of each file and directory being generated:

```
node kenai.js project app loudly
```

Kenai invokes django's startproject command, which gives you a good amount of sensible defaults, but not enough.

Here's what that command will scaffold:

```
project_root/
    manage.py
    project/
        settings.py
        urls.py
    app/
        views.py
        urls.py
        templates/
            appName/
                index.html
```

If you added the 'loudly' flag, you would get messages such as:
"Created project_root/app/urls.py"
