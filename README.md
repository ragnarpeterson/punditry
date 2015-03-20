# Punditry

A super-slim wrapper on top of [Pundit](https://github.com/elabs/pundit).

## Installation

Add this line to your application's Gemfile:

    gem 'punditry'

And then execute:

    $ bundle

Include Punditry in your application controller:

``` ruby
class ApplicationController < ActionController::Base
  include Punditry::Controller
end
```

## Usage

Punditry is essentially Pundit with a few minor additions. Instead of calling `authorize`, you call `authorize!`. This delegates to `authorize` underneath but will also return the passed in resource, allowing you to eliminate a line of code:

``` ruby
# with Pundit
def update
  @post = Post.find(params[:id])
  authorize @post
  if @post.update(post_params)
    redirect_to @post
  else
    render :edit
  end
end
```

``` ruby
# with Punditry
def update
  @post = authorize!(Post.find(params[:id]))
  if @post.update(post_params)
    redirect_to @post
  else
    render :edit
  end
end
```

Woohoo! Big win! I also prefer the bang method to indicate that it raises an error when it is not authorized, but that's a matter of taste.

`authorize!` has one more addition. If you pass in a collection, it also calls `policy_scope` on the resource. This makes the assumption that you want to authorize `index` actions as well, instead of only scoping them. This is another matter of taste. Also, reflecting this assumption, Punditry verifies that every action calls `authorize!` including `index`. If you need to opt out of this, you can simply call `skip_authorization` in your controller:

``` ruby
class PostsController < ApplicationController
  skip_authorization only: :check

  def check
  	# some action that does not require authorization
  end
end
```

`Punditry::Controller` gives you one other helper method. If you follow the recommendations [here](https://github.com/elabs/pundit#strong-parameters), then you can simply pass a resource to `whitelist` and get back the permitted attributes for that resource:

``` ruby
def update
  @post = authorize!(Post.find(params[:id]))
  if @post.update(whitelist(@post))
    redirect_to @post
  else
    render :edit
  end
end
```

Punditry also provides you with a base policy `Punditry::Policy` that all of your polices should inherit from. This policy is very basic, but using it allows you to write tests like [this](http://thunderboltlabs.com/blog/2013/03/27/testing-pundit-policies-with-rspec/). Simply require `punditry/rspec` in your `spec_helper/rails_helper`.

That's it. Punditry simply leverages the power and simplicity of Pundit while making things just slightly more convenient.
