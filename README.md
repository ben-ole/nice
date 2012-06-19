# Nice \[franz. nis\]

## What?

*Nice* is a light-weight engine which puts some *magic* into JS/AJAX driven Rails pages with the aim to ease the development of rich and interactive restful web applications.

Go [here](http://nice.codebility.com) for an example and a detailed description.

## How to use

### Requirements

This gem was tested with **Rails 3.2** but should also work with Rails 3.1 which introduced the *Asset-Pipeline* used by this gem. 
Furthermore, the current version uses **JQuery** to manipulate the DOM tree, so you should have the appropriate files in place. Although, it is easily possible to replace this by other frameworks (see *Contribution Section*) 

### Install

1. Add Gem dependency to your Gemfile

	```ruby
	#.Gemfile

	gem 'nice'
	```

2. Run 

	```
	bundle install
	```

3. Add Middleware

	```ruby
	#config/application.rb

	config.middleware.use Nice::Middleware
	```

4. Require Gem javascript in your applicaton.js manifest

	```js
	//app/assets/javascripts/application.js

	//= require nice_jquery
	```

### Basic Usage

The idea is to combine all views of one controller into one layout file exactly as it was already possible with rails and make heavy use of **yield()** and **content_for** tags to include view specific content. 
The convention of rails is to put a file named after your controller inside the *app/views/layouts/* folder. Such a file could look like this

```haml
-# app/views/layouts/books.html.haml

- content_for :content do
  %div
    .one{"data-state" => "get_books"}
      %h1 Only visible in state index
      = yield(:container1)
    .two{"data-state" => "get_books_show"}
      %h1 Only visible in state show
      = yield(:container1)

= render :template => 'layouts/application'
```

```haml
-# app/views/layouts/application.html.haml

\#{content_for?(:content) ? yield(:content) : yield}
```

-  The *content_for* tag will make sure the following context gets rendered in the application layout file \(see [Rails Guide](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts) for a deeper understanding of nested layouts\).
-  *.one{"data-state" => "get_books"}* is [HAML](http://haml.info/) code to generate a DIV block with a HTML5 attribute **data-state**. This is the key part: The value of the **data-state** attribute *marks the state in which the annotated element should be included*. This attribute can also hold a list of *space-separated* state names.
-  *= yield(:container1)* is a placeholder where content from the view file will be inserted at runtime.
-  The last line is part of the nexted layout design and just makes sure that this *books* layout page gets rendered inside the application layout.

There is one golden rule when programming with this state engine:

**All elements bounded to one or more states \(meaning that they are annotated with a *data-state* attribute\) must live in the *layout* file but not in a *view*!** 

This restriction is imposed by the way how the middleware calculates reference points for elements but should normally not effect your workflow - just keep it in mind.

All links in your application should now use the ```:remote => :true``` attribute to ensure the requests will be sent using javascript by default.

### State Transitions

Nice offers the ability to make your state changes even smoother by using either JS and/or CSS. Every element inside a <code>data-state</code> with <code>data-state-transition=\"default\"</code> will be animated using the corresponding transition configuration. By default, a linear fade-in over 200ms is used, but you can override or configure any other property animation. You need to provide your configuration by creating some JS functions. I recommend using [coffee-script](http://coffeescript.org) and name the file *nice-transitions.js.coffee*:

```
class this.NiceTransitions
	@default = 
		duration: 1000
		easing: "linear"
		properties:
			opacity: 0.0
	
	@fade_slow = 
		duration: 2000
		easing: "linear"			
		properties:
			opacity: 0.0
			
	@slide_top =
		duration: 1000
		easing: "swing"			
		properties:
			"top": "-200px"
```			

The body class gets the always a CSS class with the following naming convention assigned: <code>state-\{current_state_name\}</code>. You can use this to configure your styles per state like this:

```
.state-get_basic_a{
	.set2, .set3{
		opacity: 0.4;
	}
}
```

### Features

*Nice* is still in early stages and there is truly a lot to do. If you feel intrested and want to contribute, please don't hestitate to start work on one of the following features or enhance existing ones. 

-  state annotation via HTML5 data attribute **data-state**
-  elements can belong to more than one state annotated by space separated list
-  naming convention for state names follows the appropriate REST route: method_controller_action
-  if an elements exist in the current and the following state it can be optionally left untouched with the **data-state-update** property set to *no*. Default is true.
-  automated Browser history management
-  javascript code for DOM manipulation is separated and can be replaced to use other frameworks easily \(just remove *nice_jquery* requirement in application.js manifest and put your own methods in place. Hava a look in *Nice-GEM/lib/assets/javascripts/dom_jquery.js.coffee* and *Nice-GEM/lib/assets/javascripts/dom_jquery.js.coffee* for the signature to implement\)

## Behind the scenes

Nice is a middleware which processes all HTML and JS requests by either removing non-state specific content from the rendered page or generates JS code to manipulate the DOM tree client side.

## Roadmap / Contribute

-  css class manipulation and css3 transition support
-  test cases
-  customization of state names
-  customization of HTML5 attribute names
-  add more js events which can be catched by application
-  preloading of states (for elements which do not require updated backend data)

# License
This project rocks and uses MIT-LICENSE.