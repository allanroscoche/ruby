module PagSeguro
  class PreApproval
    include Extensions::MassAssignment
    include Extensions::EnsureType

    # Auto Charge
    attr_accessor :charge

    # Set the charger name.
    attr_accessor :name

    # Set the sender details
    attr_accessor :details

    # Set the Amount per Payment
    attr_accessor :amount_per_payment

    # Set the period of charge
    attr_accessor :period

    # Set Final date for charging
    attr_accessor :final_date

    # Set the max total amount of the charge
    attr_accessor :max_total_amount

  end
end
