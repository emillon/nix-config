# build into `result`
build:
    home-manager build --flake .

# use this configuration
switch:
    home-manager switch --flake .
