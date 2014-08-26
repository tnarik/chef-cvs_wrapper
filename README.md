# cvs_wrapper cookbook

[![Build Status](http://img.shields.io/travis/tnarik/cvs_wrapper.svg)](https://travis-ci.org/tnarik/cvs_wrapper)

# Requirements

During the development of this cookbook, the main tool used is [chefdk](http://downloads.getchef.com/chef-dk/), which code is available [here](https://github.com/opscode/chef-dk/). There are some additional gems that are documented in the project `Gemfile`. This also allows development in older environments (in general I take my code with me in a USB stick) like MacOSX 10.7, where [chefdk](http://downloads.getchef.com/chef-dk/) is not supported, but the gem version of the tools can be used.

To allow seemless integration of gems, I am using the following approach:

- use [direnv](https://github.com/zimbatm/direnv) and a `.envrc` file to ensure the `chefdk` ruby environment is used when switching to the project folder.

   ```
   use_chefdk() {
     eval "$(chef shell-init zsh)"
   }
   use chefdk
   ```
   Just use your preferred shell instead of `zsh`.
- use the first folder from `gem env gempath` (which should be a user folder) as destination for the bundle install
- `bundle install --path $(gem env gempath | cut -f1 -d\: | sed -e 's/\/ruby\/2.1.0//g')`
- as a note, the `vendor/bundle` could also be used, but my goal is integrating with the chefdk installation (via bundler).

This adds some gem duplication right now, but I hope everything is ok (work in progress).



# Usage

This cookbook allows to different setups. In static mode (```
node[:cvs_wrapper][:style] = "static"```) it will determine the connectivity to the different CVS repositories and configure the SSH tunnels accordingly.

In automatic mode (```node[:cvs_wrapper][:style] = "auto"```) it will perform the connectivity check at runtime. This requires sudo access for the user so that it can modify the ```/etc/hosts``` file during runtime.

```node[:cvs_wrapper][:sudo]``` controls that (the default is ```true```). Otherwise, the changing of the ```/etc/hosts``` file is out of scope.

Ideally the cookbook should allow for other solutions, but that is covering my use cases.

# Attributes

# Recipes

# Author

Author:: Tnarik Innael (tnarik@lecafeautomatique.co.uk)
