

# Windows install

First, edit your powershell launch profile using ``code %PROFILE``

Inside this file, add the following:

- ``Invoke-Expression (&starship init powershell)``

- ``[System.Environment]::SetEnvironmentVariable('STARSHIP_CONFIG','C:\Users\tjcwilk\local_files\repos\dotfiles\starship\starship.toml', 'User')``
