class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cpf, :position, presence: true
  validates :cpf, :email, uniqueness: true
  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    return if cpf.blank?
    return if CPF.valid?(cpf)

    errors.add(:cpf, 'Cpf deve ser válido')
  end
end
