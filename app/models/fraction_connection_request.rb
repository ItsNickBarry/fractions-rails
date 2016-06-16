class FractionConnectionRequest < ActiveRecord::Base
  validates :requester, :requestee, :offer, presence: true
  validates :requester, uniqueness: { scope: :requestee,
    message: "" }
  validate :complimentary_request_does_not_exist
  validate :connection_does_not_exist, if: [:requester, :requestee]
  validate :offer_is_valid
  validate :request_does_not_overwrite_parent, if: :requester
  validate :request_does_not_cause_loop, if: [:requester, :requestee]

  belongs_to :requester, class_name: 'Fraction'
  belongs_to :requestee, class_name: 'Fraction'

  private

    def complimentary_request_does_not_exist
      if FractionConnectionRequest.find_by(requester: requestee, requestee: requester, offer: self.offer == 'child' ? 'parent' : 'child')
        errors.add(:requestee, 'has already requested complimentary connection')
      end
    end

    def connection_does_not_exist
      if requester.parent == requestee
        errors.add(:requestee, 'is already parent of requester')
      elsif requestee.parent == requester
        errors.add(:requester, 'is already parent of requestee')
      end
    end

    def request_does_not_overwrite_parent
      if requester.parent && offer == 'child'
        errors.add(:requester, 'already has a parent')
      end
    end

    def offer_is_valid
      unless ['child', 'parent'].include? self.offer
        errors.add(:offer, 'must be "child" or "parent"')
      end
    end

    def request_does_not_cause_loop
      case self.offer
      when 'child'
        if requester.descendants.find_by name: requestee.name
          errors.add(:requester, 'must not be ancestor of requestee')
        end
      when 'parent'
        if requester.ancestors.find_by name: requestee.name
          errors.add(:requester, 'must not be descendant of requestee')
        end
      end
    end
end
