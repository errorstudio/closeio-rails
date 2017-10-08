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

## Configuration
Configure the gem in an initializer like this:

```
   Rails.application.config.to_prepare do
     Closeio::Rails.configure do |config|
         config.api_key = 'your key' #or put in Rails secrets, or somewhere else
         config.verbose = false
     end
   end
```

You can add your own methods into the Closeio::Rails models by including them in your initializer like this:

```
    # Leadmethods and ContactMethods are modules in your Rails project. Obviously they could be namespaced, etc.
     Closeio::Rails::Lead.send(:include, LeadMethods)
     Closeio::Rails::Contact.send(:prepend, ContactMethods)
```

You might want to add actions to the webhooks controller, too. Sometimes we use this on applications with some sort of authentication defined in `ApplicationController`, which needs to be ignored on the webhooks controller:

```
     Closeio::Rails::WebhooksController.send(:skip_before_action, :authenticate_user!)
     Closeio::Rails::WebhooksController.send(:skip_after_action, :verify_authorized)
```

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

### Consuming webhooks in your application
The controller doesn't do anything when it receives a webhook - instead it uses ActiveSupport::Notifications to allow you to subscribe to the raised events to do what you need to. Here's an example:

```
ActiveSupport::Notifications.subscribe(/closeio\.(create|update|delete)/) do |name, start, finish, id, payload|
  if payload[:model] == 'lead'
    SomeLeadRelatedJob.perform_later payload[:data][:id]
  end
end
```

Check the Close.io docs to get a sense of what you get in the payload - one important thing to nose is that when you get a 'closeio.merge' notification, you don't get an ID, you'll get a `:source_id` and a `:destination_id`.

Importantly, if you're using ActiveJob with the `inline` strategy you'll need to make sure you rescue from any failures, or the controller won't return a 200 OK and Close.io will keep retrying.

# Contributing
Pull requests welcome. The usual drill: fork, commit changes, PR.

# Licence
MIT - see LICENCE.txt.


      




