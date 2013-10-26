puts File.dirname(__FILE__)
require File.dirname(__FILE__) + '/test_helper.rb' 


class EmailAuthenticationTest <  Minitest::Test

  def setup
    @f=EmailAuthentication::Base.new
    @success='scott.sproule@ficonab.com'
    @failruntimeerror=[nil,""]
    @from='scott.sproule@estormtech.com'
  end
  
  def test_basic
    assert @f!=nil, "should be valid #{@f.inspect}"
  end
  
  def test_checknil
        
         assert_raises(RuntimeError) do
          @f.check(nil," ")
        end 
  
   end
   def test_checknil2

          assert_raises(RuntimeError) do
           @f.check("nil","")
         end 

    end
   def test_checkfailruntime
        @failruntimeerror.each { |add| 
          assert_raises(RuntimeError) do
           @f.check(add,@from)
         end 
       }

    end
  
    def test_goodemail
          success,msg= @f.check(@success,@from)
          assert success,"check did not succeed #{msg}"
      end
        def test_resolver_onlyonce
              res=@f.resolver
              assert res!=nil, "should have resolver"
              assert res==@f.resolver, "resolver should return same on second call #{res}, #{@f.resolver}"

          end
      #check a particular format
      def test_checkformat_good
            @f.set_address(@success,@from)
            success,msg= @f.check_format
            assert success,"check did not succeed"

        end
         def test_class_variable
                success,msg= EmailAuthentication::Base.check(@success,@from)
                assert success,"check did not succeed"

            end
         def test_bademails
             ['test','test#sed', 'test@jack'].each { |e| 
                @f.set_address(e,@from)
                success,msg= @f.check_format
                assert !success,"check did  succeed but it should not for #{e}"
              }

            end
 

end
