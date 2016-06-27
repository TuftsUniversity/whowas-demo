# whowas-demo

A **non-functional** example of how [Whowas](https://github.com/TuftsUniversity/whowas) can be integrated into a Rails app.

Why non-functional?  Whowas necessarily relies on third-party services.  Instead of running instances of any of these services, this demo app simply includes the code and configuration details for how to connect to each one as if they were running.  Thus, if you clone this app and run `Whowas.search`, it will return a ServiceUnavailable error.

The purpose of this demo is not to give you a fully-functional app to use; rather, it is to provide code examples of Search Methods, Recipes, and configuration details described in the Whowas wiki.

## What should I look at?

Useful files and folders include:

    * app/apis/
    * app/models/whowas_search.rb
    * app/recipes/
    * app/search_methods/
    * config/initializers/whowas.rb
    * spec/

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TuftsUniversity/whowas-demo, particularly if you have created a new API or extended the functionality of Whowas in any way.