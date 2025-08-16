require 'rails_helper'

RSpec.describe User, type: :model do
  it 'returns the full_name for a user' do
    user = User.create(first_name: 'Colby', last_name: 'Johnson')

    expect(user.full_name).to eq 'Colby Johnson'
  end
end
