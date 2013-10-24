Rack-pjax [![stillmaintained](http://stillmaintained.com/eval/rack-pjax.png)](http://stillmaintained.com/eval/rack-pjax) [![travis](https://secure.travis-ci.org/eval/rack-pjax.png?branch=master)](https://secure.travis-ci.org/#!/eval/rack-pjax)
========

Rack-pjax is middleware that lets you serve 'chrome-less' pages in respond to [pjax-requests](https://github.com/defunkt/jquery-pjax).

It does this by simply filtering the generated page; only the title and inner-html of the pjax-container are sent to the client.

While this won't save you any time rendering the page, it gives you more flexibility where or how to define the pjax-container.
Ryan Bates featured [rack-pjax on Railscasts](http://railscasts.com/episodes/294-playing-with-pjax) and explains how this gem compares to [pjax_rails](https://github.com/rails/pjax_rails).

Installation
------------

Check out the [Railscasts' notes](http://railscasts.com/episodes/294-playing-with-pjax) how to integrate rack-pjax in your Rails 3.1 application.

You can find the source from the screencast over [here](https://github.com/ryanb/railscasts-episodes/tree/master/episode-294).

Another sample-app: the original [pjax-demo](http://pjax.heroku.com/) but with rack-pjax onboard can be found in the [sample-app](https://github.com/eval/rack-pjax/tree/sample-app) branch.

The more generic installation comes down to:

I. Add the gem to your Gemfile

```ruby
    # Gemfile
    gem "rack-pjax"
```

II. Include **rack-pjax** as middleware to your application(-stack)

```ruby
    # config.ru
    require ::File.expand_path('../config/environment',  __FILE__)
    use Rack::Pjax
    run RackApp::Application
```

III. Install [jquery-pjax](https://github.com/defunkt/jquery-pjax). Make sure to add the 'data-pjax-container'-attribute to the container.

```html
    <head>
      ...
      <script src="/javascripts/jquery.js"></script>
      <script src="/javascripts/jquery.pjax.js"></script>
      <script type="text/javascript">
        $(function(){
          $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax('[data-pjax-container]')
        })
      </script>
      ...
    </head>
    <body>
      <div data-pjax-container>
        ...
      </div>
    </body>
```

IV. Fire up your [pushState-enabled browser](http://caniuse.com/#search=pushstate) and enjoy!


Requirements
------------

- Nokogiri


Contributors
------

* [eval](https://github.com/eval)
* [matthooks](https://github.com/matthooks)
* [koszta](https://github.com/koszta)
* [luizcosta](https://github.com/luizcosta)
