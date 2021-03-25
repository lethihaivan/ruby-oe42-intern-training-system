class User < ApplicationRecord
  enum status: {admin: 1, trainer: 2, trainee: 3}
end
