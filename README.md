## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frondit', github: 'jpmobiletanaka/frondit'
```

And then execute:

    $ bundle

## Usage

Add to your ApplicationController

    include Frondit

And then call from any controller you want:

    frondit `policy`, [ only: `rules list, on: `actions list`, record: `record` ]

`policy` is a class_name or underscored class_name: `Admin::PostPolicy` or `admin/post_policy`

For example:
```
before_action :set_post
...
frondit :post_policy, only: %i[show? edit? update?], on: %i[index show], record: :@post
frondit AuthorPolicy, on: :index, record: :@post
frondit :book_policy, record: :@post
frondit Admin::PostPolicy
...
def set_post
  @post = Post.find(params[:post_id])
end
```
### Note: 
`record` should be string/symbol with variable name which available `before` action.

You should declare `before_action` method with assigning variable before call `frondit`.

If your variable is `@post`, you should pass `:@post` or `"@post"` to frondit

## Result
After that your policies will be accessed from JS
```js
policies() // => Array
```
Particular policy:
```js
policy('PostPolicy') // => Object
policy('PostPolicy').index // => true
policy('PostPolicy').edit // => false
```
## Warning
Be careful, always use Pundit policies and his `authorize` method in your controllers while using Frondit.
Frondit isn't secure because of JS constrains.

## Support

Frondit supports Ruby 2.2+, Rails. 4.1+

## FIXME
- Tests coverage is poor
