puts File.dirname(__FILE__)
require File.dirname(__FILE__) + '/test_helper.rb' 


class EmailMXAuthenticationTest <  Minitest::Test

  def setup
    @f=EmailAuthentication::Base.new
    @success='scott.sproule@ficonab.com'
    @failruntimeerror=[nil,""]
    
  end
  
  def test_good_domain
        @f.set_address(@success)
        success,msg= @f.check_mx
        assert success,"check did not succeed"
        assert @f.mx!=nil, "mx should be set"

    end
    
    def test_bad_domain
          @f.set_address('test@baddomainxx23345.com')
          success,msg= @f.check_mx
          assert !success,"check did not succeed"

      end
      def test_bad_domain2
            @f.set_address('test@baddom  ainxx23345.com')
            success,msg= @f.check_mx
            assert !success,"check did not succeed"

        end
 
    
  
 
 

end
