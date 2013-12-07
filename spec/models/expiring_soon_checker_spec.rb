require 'spec_helper'

describe ExpiringSoonChecker do

  let(:date) { date }
  let(:payment_1) { double }
  let(:payment_2) { double }
  let(:payments) { [payment_1, payment_2] }
  let(:delayed_mailer) { double }

  before do
    Payment.stub_chain(:active_payments, :expiring_soon) { payments }
    UserMailer.stub(:delay) { delayed_mailer }
  end

  it "checks" do
    delayed_mailer.should_receive(:voucher_expiring_soon).with(payment_1)
    delayed_mailer.should_receive(:voucher_expiring_soon).with(payment_2)

    ExpiringSoonChecker.new.check
  end

end
