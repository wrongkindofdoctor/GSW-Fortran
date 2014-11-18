!==========================================================================
elemental function gsw_entropy_from_pt (sa, pt)
!==========================================================================
!
!  Calculates specific entropy of seawater. 
!
!  SA  =  Absolute Salinity                                        [ g/kg ]
!  pt  =  potential temperature (ITS-90)                          [ deg C ]
!
!  entropy  =  specific entropy                                [ J/(kg*K) ]
!--------------------------------------------------------------------------

use gsw_mod_toolbox, only : gsw_gibbs

implicit none
integer, parameter :: r14 = selected_real_kind(14,30)

real (r14), intent(in) :: sa, pt

real (r14) :: gsw_entropy_from_pt

integer, parameter :: n0 = 0 
integer, parameter :: n1 = 1

real (r14), parameter :: pr0 = 0d0

gsw_entropy_from_pt = -gsw_gibbs(n0,n1,n0,sa,pt,pr0)

return
end function

!--------------------------------------------------------------------------
