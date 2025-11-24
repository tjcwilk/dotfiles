

# Windows install

First, edit your powershell launch profile using ``code %PROFILE``

Inside this file, add the following:

```
$ENV:STARSHIP_CONFIG = 'C:\Users\tjcwilk\local_files\repos\dotfiles\starship\starship.toml'

Invoke-Expression (&starship init powershell)
```
