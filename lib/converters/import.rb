class Converters::Import
  class << self
    def run!
      # Here is where I need to execute the rake task to wipe out the assets that are on disk (parts, reference figures, etc)
      # Rake Task to pull down 'old' database
      # cap sonnax:db:pull_old
      # Rake task to pull down 'old' assets (where mine are symlinked)
      # cap sonnax:assets:pull_old

      puts 'Running the rake tasks to destroy local assets...'
      `rake sonnax:assets:destroy`
      
      puts 'Running the task to empty the assets table...'
      Converters::Asset.truncate!
      Converters::PartAsset.truncate!
      
      puts '-----------------------------------'
      puts 'Converting data...'
      
      puts 'Converting the Users...'
      Converters::User.run!
      
      puts 'Converting the Distributors...'
      Converters::Distributor.run!
      
      puts 'Converting the Makes...'
      Converters::Make.run!
      
      puts 'Converting the Product Lines'
      Converters::ProductLine.run!
      
      puts 'Converting the Reference Figures...'
      Converters::ReferenceFigure.run!
      
      puts 'Converting the Units...'
      Converters::Unit.run!
      
      puts 'Converting the Unit Makes...'
      Converters::UnitsMake.run!
      
      puts 'Converting the Part Types...'
      Converters::PartType.run!
      
      puts 'Converting the Part Asset Types...'
      Converters::PartAssetType.run!
      
      puts 'Converting the Part Attribute Types...'
      Converters::PartAttributeType.run!
      
      puts 'Converting the Part Photos...'
      Converters::PartPhoto.run!
      
      puts 'Converting the Parts...'
      Converters::Part.run!
      
      puts 'Converting the Unit Components...'
      Converters::UnitComponent.run!
      
      # Once this is all completed, we need to:
      # 1. Push the new database to the remote server
      # cap sonnax:db:push
      # 2. Push the new assets to the remote server
      # cap sonnax:assets:destroy:remote
      # cap sonnax:assets:push
      # 3. Re-index the database on the local server
      # cap ts:index:rebuild
      # 4. Re-index the database on the remote server
      # rake ts:index:rebuild
      # 5. Run the SQL to update the product lines names
    end
  end
end