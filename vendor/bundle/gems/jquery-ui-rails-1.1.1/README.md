# jquery-ui-rails

[![Build Status](https://secure.travis-ci.org/joliss/jquery-ui-rails.png?branch=master)](http://travis-ci.org/joliss/jquery-ui-rails) [![Dependency Status](https://gemnasium.com/joliss/jquery-ui-rails.png)](https://gemnasium.com/joliss/jquery-ui-rails)

This gem packages the jQuery UI 1.8.20 assets (JavaScripts, stylesheets, and
images) for the Rails 3.1+ [asset
pipeline](http://guides.rubyonrails.org/asset_pipeline.html), so you never have
to download a custom package through the [web
interface](http://jqueryui.com/download) again.

## Usage

In your Gemfile, add:

```ruby
group :assets do
  gem 'jquery-ui-rails'
end
```

## Require Everything

To require all jQuery UI modules, add the following to your application.js:

```javascript
//= require jquery.ui.all
```

Also add the jQuery UI CSS to your application.css:

```css
/*
 *= require jquery.ui.all
 */
```

All images required by jQuery UI are automatically served through the asset
pipeline, so you are good to go! For example, this code will add a
[datepicker](http://jqueryui.com/demos/datepicker/):

```javascript
$(function() {
  $('.datepicker').datepicker();
});
```

## Require Specific Modules

The jQuery UI code weighs 51KB (minified + gzipped) and takes a while to
execute, so for production apps it's recommended to only include the modules
that your application actually uses. Dependencies are automatically resolved.
Simply pick one or more modules from the asset list below.

For example, if you only need the datepicker module, add this to your
application.js:

```javascript
//= require jquery.ui.datepicker
```

In your application.css, require the corresponding CSS module:

```css
/*
 *= require jquery.ui.datepicker
 */
```

## JavaScript Assets

### UI Core

```javascript
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.position
```

You usually do not need to require these directly, as they are pulled in by the
other JavaScript modules as needed.

### Interactions

```javascript
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require jquery.ui.resizable
//= require jquery.ui.selectable
//= require jquery.ui.sortable
```

For `jquery.ui.resizable` and `jquery.ui.selectable`, remember to `require`
their matching CSS files in your application.css as well.

### Widgets

```javascript
//= require jquery.ui.accordion
//= require jquery.ui.autocomplete
//= require jquery.ui.button
//= require jquery.ui.dialog
//= require jquery.ui.slider
//= require jquery.ui.tabs
//= require jquery.ui.datepicker
//= require jquery.ui.progressbar
```

For all of these, remember to `require` their matching CSS files in your
application.css as well.

Datepicker has optional i18n modules for non-US locales, named
`jquery.ui.datepicker-xx[-YY]`
([list](https://github.com/jquery/jquery-ui/tree/1.8.20/ui/i18n)), for example:

```javascript
//= require jquery.ui.datepicker-pt-BR
```

### Effects

```javascript
//= require jquery.effects.all
//= require jquery.effects.core
//= require jquery.effects.blind
//= require jquery.effects.bounce
//= require jquery.effects.clip
//= require jquery.effects.drop
//= require jquery.effects.explode
//= require jquery.effects.fade
//= require jquery.effects.fold
//= require jquery.effects.highlight
//= require jquery.effects.pulsate
//= require jquery.effects.scale
//= require jquery.effects.shake
//= require jquery.effects.slide
//= require jquery.effects.transfer
```

## Stylesheet Assets

### UI Core

```css
/*
 *= require jquery.ui.core
 *= require jquery.ui.theme
 */
```

You might want to require these if you do not use any of the following modules,
but still want jQuery UI's basic theming CSS. Otherwise they are automatically
pulled in as dependencies.

### Interactions

```css
/*
 *= require jquery.ui.resizable
 *= require jquery.ui.selectable
 */
```

### Widgets

```css
/*
 *= require jquery.ui.accordion
 *= require jquery.ui.autocomplete
 *= require jquery.ui.button
 *= require jquery.ui.dialog
 *= require jquery.ui.slider
 *= require jquery.ui.tabs
 *= require jquery.ui.datepicker
 *= require jquery.ui.progressbar
 */
```

## Contributing

### Bug Reports

For bugs in jQuery UI itself, head to the [jQuery UI Development
Center](http://jqueryui.com/development).

For bugs in this gem distribution, use the GitHub issue tracker. In particular,
the asset dependencies between files are set up by this gem, not by the jQuery
UI upstream. If you find that a JavaScript or CSS file does not pull in its
dependencies correctly, please open an issue!

### Setup

The `jquery-ui-rails` gem should work in Ruby 1.8.7 apps. To run the rake
tasks, you need Ruby 1.9 however.

```bash
git clone git://github.com/joliss/jquery-ui-rails.git
cd jquery-ui-rails
git submodule update --init
bundle install
bundle exec rake # rebuild assets
```

Most of the code lives in the `Rakefile`. Pull requests are more than welcome!

### Hacking jQuery UI

The jquery-ui-rails repository is
[contributor-friendly](http://www.solitr.com/blog/2012/04/contributor-friendly-gems/)
and has a git submodule containing the official [jquery-ui
repo](https://github.com/jquery/jquery-ui). This way it's easy to hack the
jQuery UI code:

```bash
cd jquery-ui
git checkout master  # or 1-8-stable
... hack-hack-hack ...
bundle exec rake  # rebuild assets based on your changes
```

Assuming your app's Gemfile points at your jquery-ui-rails checkout (`gem
'jquery-ui-rails', :path => '~/path/to/jquery-ui-rails'`), all you need to do
now is refresh your browser, and your changes to jQuery UI are live in your
Rails application.

You can send pull requests to the
[jquery-ui](https://github.com/jquery/jquery-ui) GitHub project straight out of
your submodule. See also their
[Getting Involved](http://wiki.jqueryui.com/w/page/35263114/Getting-Involved)
guide.

### Testing

As a smoke test, a `testapp` application is available in the repository, which
displays a check mark and a datepicker to make sure the assets load correctly:

```bash
cd testapp
bundle install
rails server
```

Now point your browser at [http://localhost:3000/](http://localhost:3000/).

## Limitations

*   Only the base theme (Smoothness) is included. Once it becomes possible to
    [generate all theme
    files](https://forum.jquery.com/topic/downloading-bundling-all-themes#14737000003080244)
    from the jQuery UI sources, we can package all the other themes in the
    [ThemeRoller](http://jqueryui.com/themeroller/) gallery.

    Perhaps we can also add helper tasks to help developers generate assets for
    their own custom themes or for third-party themes (like
    [Selene](http://gravityonmars.github.com/Selene/)).

    If you still want a different theme right now, you could probably download
    a custom theme and require the theme CSS *after* requiring any other jQuery
    UI CSS files you need, making sure to serve up the theme images correctly.
    (This is arguably cumbersome, not officially supported by this gem, and
    adds 1 KB overhead as both the base theme and the custom theme are served
    up.)

*   The `jquery.ui.all.js` file is named `jquery-ui.js` in the official
    distribution. We should follow their naming. But jquery-rails provides a
    `jquery-ui.js` asset as well, so until that is removed from the
    jquery-rails gem (see issue
    [#46](https://github.com/rails/jquery-rails/issues/46)), we cannot
    distribute `jquery-ui.js` without risking conflicts.

    To reduce confusion, as long as there is no `jquery-ui.js`, we also do not
    distribute the official `jquery-ui-i18n.js` and `jquery-ui.css`. The latter
    is available as `jquery.ui.all.css` however.
