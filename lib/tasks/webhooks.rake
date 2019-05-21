namespace :closeio do
  namespace :rails do
    desc "List webhooks"
    task list_webhooks: :environment do
      Closeio::Rails::Webhook.all.each do |webhook|
        puts "id:#{webhook.id} endpoint:#{webhook.url}"
      end
    end

    desc "Create webhook with defined endpoints"
    task :create_leads_webhook, [:endpoint] => :environment do |task, args|
      url = args[:endpoint]
      raise Closeio::Rails::Error, "You need to include an endpoint URL or have configured the default URL for your environment" unless url.present?
      Closeio::Rails::Webhook.create({
        url: url,
        events: [
          {
            object_type: 'lead',
            action: 'created'
          },
          {
            object_type: 'lead',
            action: 'updated'
          },
          {
            object_type: 'lead',
            action: 'deleted'
          },
          {
            object_type: 'lead',
            action: 'merged'
          }
        ]
                                   })
    end

    desc "Remove a webhook by ID"
    task :destroy_webhook, [:id] => :environment do |task, args|
      raise Closeio::Rails::Error, "You need to include a webhook subscription ID to destroy it" unless args[:id].present?
      Closeio::Rails::Webhook.destroy!(args[:id])
    end
  end
end