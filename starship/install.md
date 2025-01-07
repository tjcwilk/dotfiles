

# Windows install

code %PROFILE 
Invoke-Expression (&starship init powershell)

[System.Environment]::SetEnvironmentVariable('STARSHIP_CONFIG','C:\Users\tjcwilk\local_files\repos\dotfiles\starship\starship.toml', 'User')