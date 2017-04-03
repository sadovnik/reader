module Reader
  # Represents validation schema used for forms
  class Form
    include ActiveModel::Model
    include ActiveModel::Validations
  end
end
