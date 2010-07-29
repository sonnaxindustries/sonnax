class Converters::UnitComponent < UnitComponent
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE unit_components')
      Legacy::UnitComponent.list.each do |r|
        if r.create?
          params = {
            :unit_id                    => r.unit._model_record.id,
            :part_id                    => r.part._model_record.id,
            :display_order              => r.display_order,
            :indent                     => r.indent,
            :code_on_reference_figure   => r.code_on_ref_figure,
            :description                => r.description,
            :notes                      => r.notes,
            :steel_driveshaft_tube_od   => r.steel_driveshaft_tube_od,
            :torque_fuse_options        => r.torque_fuse_options,
            :pts_series                 => r.pts_series,
            :driveline_series           => r.driveline_series
          }

          self.create!(params)
        end
      end
    end
  end
end