class PublicationTitle < ActiveRecord::Base
  has_many :publication_categories, :class_name => 'PublicationCategoriesTitle', :dependent => :destroy
  has_many :categories, :through => :publication_categories

  has_many :publication_authors, :class_name => 'PublicationTitlesAuthor', :dependent => :destroy
  has_many :authors, :through => :publication_authors

  has_many :publication_subjects, :class_name => 'PublicationTitlesSubject', :dependent => :destroy
  has_many :subjects, :through => :publication_subjects

  has_many :publication_types, :class_name => 'PublicationTitlesType', :dependent => :destroy
  has_many :types, :through => :publication_types, :source => :publication_type

  has_many :publication_keywords, :class_name => 'PublicationTitlesKeyword', :dependent => :destroy
  has_many :keywords, :through => :publication_keywords

  has_many :publication_product_lines, :class_name => 'PublicationTitlesProductLine', :dependent => :destroy
  has_many :product_lines, :through => :publication_product_lines

  has_many :publication_units_makes, :class_name => 'PublicationTitlesUnitsMake', :dependent => :destroy
  has_many :units_makes, :through => :publication_units_makes

  has_many :publication_units, :class_name => 'PublicationTitlesUnit', :dependent => :destroy
  has_many :units, :through => :publication_units

  has_many :publication_makes, :class_name => 'PublicationTitlesMake', :dependent => :destroy
  has_many :makes, :through => :publication_makes

  has_attached_file :pdf

  define_index do
    indexes title, :sortable => true
    indexes description

    has created_at, updated_at
  end

  class << self
    def detail!(id)
      self.find_by_url_friendly!(id, :include => [:authors, :subjects, :categories, :product_lines, :types, :keywords])
    end

    def find_by_filter(attrs={})
      #attrs.assert_valid_keys(:subject, :make, :unit, :category)

      subject_id  = attrs.delete(:subject)
      make_id     = attrs.delete(:make)
      unit_id     = attrs.delete(:unit)
      category_id = attrs.delete(:category)

      joins = []
      conditions = []

      if !subject_id.blank?
        joins << 'LEFT JOIN publication_titles_subjects pts ON pts.publication_title_id = publication_titles.id'
        conditions << ["pts.publication_subject_id = ?", subject_id]
      end

      if !category_id.blank?
        joins << 'LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = publication_titles.id'
        conditions << ["pct.publication_category_id = ?", category_id]
      end

      if !make_id.blank?
        joins << 'LEFT JOIN publication_titles_makes ptm ON ptm.publication_title_id = publication_titles.id'
        conditions << ["ptm.make_id = ?", make_id]
      end

      if !unit_id.blank?
        joins << 'LEFT JOIN publication_titles_units ptu ON ptu.publication_title_id = publication_titles.id'
        conditions << ["ptu.unit_id = ?", unit_id]
      end

      self.all(:joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :include => [:authors],
               :order => 'publication_titles.published_at DESC')
    end
  end

  def product_lines?
    self.product_lines.any?
  end

  def keywords?
    self.keywords.any?
  end

  def subjects?
    self.subjects.any?
  end

  def types?
    self.types.any?
  end

  def categories?
    self.categories.any?
  end

  def authors?
    self.authors.any?
  end

  def units_makes?
    self.units_makes.any?
  end

  def remove_pdf!
    self.pdf = nil
    self.save(false)
  end

  def to_param
    self.url_friendly
  end

  def generate_url_friendly!
    formatted_friendly = self.title.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end

  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end
