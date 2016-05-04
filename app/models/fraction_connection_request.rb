class FractionConnectionRequest < ActiveRecord::Base
  validates :requester, :requestee, :offer, presence: true
  validates :requester, uniqueness: { scope: :requestee,
    message: "" }
  validate :complimentary_request_does_not_exist
  validate :not_already_connected
  validate :offer_is_valid
  validate :will_not_cause_loop

  belongs_to :requester, class_name: 'Fraction'
  belongs_to :requestee, class_name: 'Fraction'

  # TODO destroy on connection
  private

    def complimentary_request_does_not_exist
      if FractionConnectionRequest.find_by(requester: requestee, requestee: requester, offer: self.offer == 'child' ? 'parent' : 'child')
        errors.add(:requestee, 'has already requested complimentary connection')
      end
    end

    def not_already_connected
      return if requestee.nil? || requester.nil?
      if requester.parent && offer == 'child'
        errors.add(:requester, 'already has a parent')
      elsif requester.parent == requestee
        errors.add(:requestee, 'is already parent of requester')
      elsif requestee.parent == requester
        errors.add(:requester, 'is already parent of requestee')
      end
    end

    def offer_is_valid
      unless ['child', 'parent'].include? self.offer
        errors.add(:offer, 'must be "child" or "parent"')
      end
    end

    def will_not_cause_loop
      return if requestee.nil? || requester.nil?
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
