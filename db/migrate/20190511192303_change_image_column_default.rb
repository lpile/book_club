class ChangeImageColumnDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :books, :image, from: nil, to: "http://clipart-library.com/images/6cr5yaAqi.png"
  end
end
