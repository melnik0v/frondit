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

    frondit :post_policy, only: %i[show? edit? update?], on: %i[index show], record: :@post
    frondit AuthorPolicy, on: :index, record: :@post
    frondit :book_policy, record: :@post
    frondit Admin::PostPolicy

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
policy(name) // => Object
```

## Support

Frondit supports Ruby 2.2+, Rails. 4.1+