!==========================================================================
elemental function gsw_ct_from_t (sa, t, p) 
!==========================================================================
!   
! Calculates Conservative Temperature from in-situ temperature
!
! sa     : Absolute Salinity                               [g/kg]
! t      : in-situ temperature                             [deg C]
! p      : sea pressure                                    [dbar]
!
! gsw_ct_from_t : Conservative Temperature                 [deg C]
!--------------------------------------------------------------------------

use gsw_mod_toolbox, only : gsw_ct_from_pt, gsw_pt0_from_t

implicit none
integer, parameter :: r14 = selected_real_kind(14,30)

real (r14), intent(in) :: sa, t, p 

real (r14) :: gsw_ct_from_t

real (r14) :: pt0

pt0 = gsw_pt0_from_t(sa,t,p)
gsw_ct_from_t = gsw_ct_from_pt(sa,pt0)

return
end function

!--------------------------------------------------------------------------
