require 'administrate/base_dashboard'

class ProfileBlockDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    text_blocks: Field::HasMany,
    question_blocks: Field::HasMany,
    ranking_blocks: Field::HasMany,
    yes_or_no_blocks: Field::HasMany,
    favorite_blocks: Field::HasMany,
    address_block: Field::HasOne,
    user: Field::BelongsTo,
    my_favorite_block: Field::HasOne,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    text_blocks
    question_blocks
    ranking_blocks
    yes_or_no_blocks
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    text_blocks
    question_blocks
    ranking_blocks
    yes_or_no_blocks
    favorite_blocks
    address_block
    user
    my_favorite_block
    id
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    text_blocks
    question_blocks
    ranking_blocks
    yes_or_no_blocks
    favorite_blocks
    address_block
    user
    my_favorite_block
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how profile blocks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(profile_block)
  #   "ProfileBlock ##{profile_block.id}"
  # end
end
