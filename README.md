# cvs_wrapper cookbook

# Requirements

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
