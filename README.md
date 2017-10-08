# Closeio::Rails
A handy wrapper around the `closeio` gem to make Rails integration a little easier.

## Models
There are 4 models defined in this gem. The aim is to have a DSL a little more like the familiar ActiveRecord one. 

### `Closeio::Rails::Base`
All the models inherit from `Closeio::Rails::Base`, which has a couple of mixins:

#### `Closeio::Rails::Attributes`
Make the model respond to `attributes()` - it returns a hash, like ActiveRecord

#### `Closeio::Rails::DateCoercion`
Parse the creation and update dates into datetime objects, and add `created_at()` and `updated_at()` methods which are in line with Rails norms.

### `Closeio::Rails::Lead`
This is where most of the action happens. Leads have contacts, of type `Closeio::Rails::Contact`

### `Closeio::Rails::Contact`
A contact entry in Close.io. Not accessible on its own; always created after a call to `Closeio::Lead

### `Closeio::Rails::CustomField`
It's often useful to create and update custom fields in Close.io programatically - changing the values of select lists and similar.
 
### `Closeio::Rails::Note`
This is a very lightweight wrapper around Close::Client#create_note.


## Mountable webhooks controller
It's useful to receive webhooks from Close.io. You have to drop a note to their support team to set it up but it's very quick.

Mount your route like this:

```
mount Closeio::Rails::Engine => "/closeio" #this can be any path you like
```

That'll give you the following routes:

```
debug_webhooks GET  /webhooks/debug(.:format) closeio/rails/webhooks#debug {:format=>:json}
webhooks POST /webhooks(.:format)       closeio/rails/webhooks#create {:format=>:json}
```

The `debug_webhooks_path` only works in development. It just sanity-checks that you've got ot mounted properly :)


      




