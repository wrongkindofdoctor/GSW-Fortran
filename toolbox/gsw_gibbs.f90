!==========================================================================
elemental function gsw_gibbs (ns, nt, np, sa, t, p)
!==========================================================================
!
! seawater specific Gibbs free energy and derivatives up to order 2
!
! ns     : order of s derivative
! nt     : order of t derivative
! np     : order of p derivative
! sa     : Absolute Salinity                               [g/kg]
! t      : temperature                                     [deg C]
! p      : sea pressure                                    [dbar]
! 
! gsw_gibbs  : specific Gibbs energy or its derivative
!--------------------------------------------------------------------------

use gsw_mod_teos10_constants, only : gsw_sfac

implicit none
integer, parameter :: r14 = selected_real_kind(14,30)

integer, intent(in) :: ns, nt, np
real (r14), intent(in) :: sa, t, p

real (r14) :: gsw_gibbs

real (r14) :: x2, x, y, z, g03, g08

x2 = gsw_sfac*sa
x = sqrt(x2)
y = t*0.025d0
z = p*1d-4

if(ns.eq.0 .and. nt.eq.0 .and. np.eq.0) then
          
  g03 = 101.342743139674d0 + z*(100015.695367145d0 + &
      z*(-2544.5765420363d0 + z*(284.517778446287d0 + &
      z*(-33.3146754253611d0 + (4.20263108803084d0 - 0.546428511471039d0*z)*z)))) + &
      y*(5.90578347909402d0 + z*(-270.983805184062d0 + &
      z*(776.153611613101d0 + z*(-196.51255088122d0 + (28.9796526294175d0 - 2.13290083518327d0*z)*z))) + &
      y*(-12357.785933039d0 + z*(1455.0364540468d0 + &
      z*(-756.558385769359d0 + z*(273.479662323528d0 + z*(-55.5604063817218d0 + 4.34420671917197d0*z)))) + &
      y*(736.741204151612d0 + z*(-672.50778314507d0 + &
      z*(499.360390819152d0 + z*(-239.545330654412d0 + (48.8012518593872d0 - 1.66307106208905d0*z)*z))) + &
      y*(-148.185936433658d0 + z*(397.968445406972d0 + &
      z*(-301.815380621876d0 + (152.196371733841d0 - 26.3748377232802d0*z)*z)) + &
      y*(58.0259125842571d0 + z*(-194.618310617595d0 + &
      z*(120.520654902025d0 + z*(-55.2723052340152d0 + 6.48190668077221d0*z))) + &
      y*(-18.9843846514172d0 + y*(3.05081646487967d0 - 9.63108119393062d0*z) + &
      z*(63.5113936641785d0 + z*(-22.2897317140459d0 + 8.17060541818112d0*z))))))))
          
  g08 = x2*(1416.27648484197d0 + z*(-3310.49154044839d0 + &
        z*(384.794152978599d0 + z*(-96.5324320107458d0 + (15.8408172766824d0 - 2.62480156590992d0*z)*z))) + &
        x*(-2432.14662381794d0 + x*(2025.80115603697d0 + &
        y*(543.835333000098d0 + y*(-68.5572509204491d0 + &
        y*(49.3667694856254d0 + y*(-17.1397577419788d0 + 2.49697009569508d0*y))) - 22.6683558512829d0*z) + &
        x*(-1091.66841042967d0 - 196.028306689776d0*y + &
        x*(374.60123787784d0 - 48.5891069025409d0*x + 36.7571622995805d0*y) + 36.0284195611086d0*z) + &
        z*(-54.7919133532887d0 + (-4.08193978912261d0 - 30.1755111971161d0*z)*z)) + &
        z*(199.459603073901d0 + z*(-52.2940909281335d0 + (68.0444942726459d0 - 3.41251932441282d0*z)*z)) + &
        y*(-493.407510141682d0 + z*(-175.292041186547d0 + (83.1923927801819d0 - 29.483064349429d0*z)*z) + &
        y*(-43.0664675978042d0 + z*(383.058066002476d0 + z*(-54.1917262517112d0 + 25.6398487389914d0*z)) + &
        y*(-10.0227370861875d0 - 460.319931801257d0*z + y*(0.875600661808945d0 + 234.565187611355d0*z))))) + &
        y*(168.072408311545d0 + z*(729.116529735046d0 + &
        z*(-343.956902961561d0 + z*(124.687671116248d0 + z*(-31.656964386073d0 + 7.04658803315449d0*z)))) + &
        y*(880.031352997204d0 + y*(-225.267649263401d0 + &
        y*(91.4260447751259d0 + y*(-21.6603240875311d0 + 2.13016970847183d0*y) + &
        z*(-297.728741987187d0 + (74.726141138756d0 - 36.4872919001588d0*z)*z)) + &
        z*(694.244814133268d0 + z*(-204.889641964903d0 + (113.561697840594d0 - 11.1282734326413d0*z)*z))) + &
        z*(-860.764303783977d0 + z*(337.409530269367d0 + &
        z*(-178.314556207638d0 + (44.2040358308d0 - 7.92001547211682d0*z)*z))))))
        
  if(sa.gt.0.d0) &
        g08 = g08 + x2*(5812.81456626732d0 + 851.226734946706d0*y)*log(x)

  gsw_gibbs = g03 + g08
  
elseif(ns.eq.1 .and. nt.eq.0 .and. np.eq.0) then
        
  g08 = 8645.36753595126d0 + z*(-6620.98308089678d0 + &
       z*(769.588305957198d0 + z*(-193.0648640214916d0 + (31.6816345533648d0 - 5.24960313181984d0*z)*z))) + &
       x*(-7296.43987145382d0 + x*(8103.20462414788d0 + &
       y*(2175.341332000392d0 + y*(-274.2290036817964d0 + &
       y*(197.4670779425016d0 + y*(-68.5590309679152d0 + 9.98788038278032d0*y))) - 90.6734234051316d0*z) + &
       x*(-5458.34205214835d0 - 980.14153344888d0*y + &
       x*(2247.60742726704d0 - 340.1237483177863d0*x + 220.542973797483d0*y) + 180.142097805543d0*z) + &
       z*(-219.1676534131548d0 + (-16.32775915649044d0 - 120.7020447884644d0*z)*z)) + &
       z*(598.378809221703d0 + z*(-156.8822727844005d0 + (204.1334828179377d0 - 10.23755797323846d0*z)*z)) + &
       y*(-1480.222530425046d0 + z*(-525.876123559641d0 + (249.57717834054571d0 - 88.449193048287d0*z)*z) + &
       y*(-129.1994027934126d0 + z*(1149.174198007428d0 + z*(-162.5751787551336d0 + 76.9195462169742d0*z)) + &
       y*(-30.0682112585625d0 - 1380.9597954037708d0*z + y*(2.626801985426835d0 + 703.695562834065d0*z))))) + &
       y*(1187.3715515697959d0 + z*(1458.233059470092d0 + &
       z*(-687.913805923122d0 + z*(249.375342232496d0 + z*(-63.313928772146d0 + 14.09317606630898d0*z)))) + &
       y*(1760.062705994408d0 + y*(-450.535298526802d0 + &
       y*(182.8520895502518d0 + y*(-43.3206481750622d0 + 4.26033941694366d0*y) + &
       z*(-595.457483974374d0 + (149.452282277512d0 - 72.9745838003176d0*z)*z)) + &
       z*(1388.489628266536d0 + z*(-409.779283929806d0 + (227.123395681188d0 - 22.2565468652826d0*z)*z))) + &
       z*(-1721.528607567954d0 + z*(674.819060538734d0 + &
       z*(-356.629112415276d0 + (88.4080716616d0 - 15.84003094423364d0*z)*z)))))
  
  if(sa.gt.0.d0) then
    g08 = g08 + (11625.62913253464d0 + 1702.453469893412d0*y)*log(x)
  else
    g08 = 0.d0
  endif
  
  gsw_gibbs = 0.5*gsw_sfac*g08

elseif(ns.eq.0 .and. nt.eq.1 .and. np.eq.0) then
               
  g03 = 5.90578347909402d0 + z*(-270.983805184062d0 + &
       z*(776.153611613101d0 + z*(-196.51255088122d0 + (28.9796526294175d0 - 2.13290083518327d0*z)*z))) + &
       y*(-24715.571866078d0 + z*(2910.0729080936d0 + &
       z*(-1513.116771538718d0 + z*(546.959324647056d0 + z*(-111.1208127634436d0 + 8.68841343834394d0*z)))) + &
       y*(2210.2236124548363d0 + z*(-2017.52334943521d0 + &
       z*(1498.081172457456d0 + z*(-718.6359919632359d0 + (146.4037555781616d0 - 4.9892131862671505d0*z)*z))) + &
       y*(-592.743745734632d0 + z*(1591.873781627888d0 + &
       z*(-1207.261522487504d0 + (608.785486935364d0 - 105.4993508931208d0*z)*z)) + &
       y*(290.12956292128547d0 + z*(-973.091553087975d0 + &
       z*(602.603274510125d0 + z*(-276.361526170076d0 + 32.40953340386105d0*z))) + &
       y*(-113.90630790850321d0 + y*(21.35571525415769d0 - 67.41756835751434d0*z) + &
       z*(381.06836198507096d0 + z*(-133.7383902842754d0 + 49.023632509086724d0*z)))))))
              
  g08 = x2*(168.072408311545d0 + z*(729.116529735046d0 + &
        z*(-343.956902961561d0 + z*(124.687671116248d0 + z*(-31.656964386073d0 + 7.04658803315449d0*z)))) + &
        x*(-493.407510141682d0 + x*(543.835333000098d0 + x*(-196.028306689776d0 + 36.7571622995805d0*x) + &
        y*(-137.1145018408982d0 + y*(148.10030845687618d0 + y*(-68.5590309679152d0 + 12.4848504784754d0*y))) - &
        22.6683558512829d0*z) + z*(-175.292041186547d0 + (83.1923927801819d0 - 29.483064349429d0*z)*z) + &
        y*(-86.1329351956084d0 + z*(766.116132004952d0 + z*(-108.3834525034224d0 + 51.2796974779828d0*z)) + &
        y*(-30.0682112585625d0 - 1380.9597954037708d0*z + y*(3.50240264723578d0 + 938.26075044542d0*z)))) + &
        y*(1760.062705994408d0 + y*(-675.802947790203d0 + &
        y*(365.7041791005036d0 + y*(-108.30162043765552d0 + 12.78101825083098d0*y) + &
        z*(-1190.914967948748d0 + (298.904564555024d0 - 145.9491676006352d0*z)*z)) + &
        z*(2082.7344423998043d0 + z*(-614.668925894709d0 + (340.685093521782d0 - 33.3848202979239d0*z)*z))) + &
        z*(-1721.528607567954d0 + z*(674.819060538734d0 + &
        z*(-356.629112415276d0 + (88.4080716616d0 - 15.84003094423364d0*z)*z)))))
      
  if(sa.gt.0.d0) g08 = g08 + 851.226734946706d0*x2*log(x)
  
  gsw_gibbs = (g03 + g08)*0.025d0

elseif(ns.eq.0 .and. nt.eq.0 .and. np.eq.1) then
    
  g03 = 100015.695367145d0 + z*(-5089.1530840726d0 + &
        z*(853.5533353388611d0 + z*(-133.2587017014444d0 + (21.0131554401542d0 - 3.278571068826234d0*z)*z))) + &
        y*(-270.983805184062d0 + z*(1552.307223226202d0 + &
        z*(-589.53765264366d0 + (115.91861051767d0 - 10.664504175916349d0*z)*z)) + &
        y*(1455.0364540468d0 + z*(-1513.116771538718d0 + &
        z*(820.438986970584d0 + z*(-222.2416255268872d0 + 21.72103359585985d0*z))) + &
        y*(-672.50778314507d0 + z*(998.720781638304d0 + &
        z*(-718.6359919632359d0 + (195.2050074375488d0 - 8.31535531044525d0*z)*z)) + &
        y*(397.968445406972d0 + z*(-603.630761243752d0 + (456.589115201523d0 - 105.4993508931208d0*z)*z) + &
        y*(-194.618310617595d0 + y*(63.5113936641785d0 - 9.63108119393062d0*y + &
        z*(-44.5794634280918d0 + 24.511816254543362d0*z)) + &
        z*(241.04130980405d0 + z*(-165.8169157020456d0 + &
        25.92762672308884d0*z)))))))                                                           
  
  g08 = x2*(-3310.49154044839d0 + z*(769.588305957198d0 + &
        z*(-289.5972960322374d0 + (63.3632691067296d0 - 13.1240078295496d0*z)*z)) + &
        x*(199.459603073901d0 + x*(-54.7919133532887d0 + 36.0284195611086d0*x - 22.6683558512829d0*y + &
        (-8.16387957824522d0 - 90.52653359134831d0*z)*z) + &
        z*(-104.588181856267d0 + (204.1334828179377d0 - 13.65007729765128d0*z)*z) + &
        y*(-175.292041186547d0 + (166.3847855603638d0 - 88.449193048287d0*z)*z + &
        y*(383.058066002476d0 + y*(-460.319931801257d0 + 234.565187611355d0*y) + &
        z*(-108.3834525034224d0 + 76.9195462169742d0*z)))) + &
        y*(729.116529735046d0 + z*(-687.913805923122d0 + &
        z*(374.063013348744d0 + z*(-126.627857544292d0 + 35.23294016577245d0*z))) + &
        y*(-860.764303783977d0 + y*(694.244814133268d0 + &
        y*(-297.728741987187d0 + (149.452282277512d0 - 109.46187570047641d0*z)*z) + &
        z*(-409.779283929806d0 + (340.685093521782d0 - 44.5130937305652d0*z)*z)) + &
        z*(674.819060538734d0 + z*(-534.943668622914d0 + (176.8161433232d0 - 39.600077360584095d0*z)*z)))))
     
  gsw_gibbs = (g03 + g08)*1d-8

elseif(ns.eq.0 .and. nt.eq.2 .and. np.eq.0) then

  g03 = -24715.571866078d0 + z*(2910.0729080936d0 + z* &
       (-1513.116771538718d0 + z*(546.959324647056d0 + z*(-111.1208127634436d0 + 8.68841343834394d0*z)))) + &
       y*(4420.4472249096725d0 + z*(-4035.04669887042d0 + &
       z*(2996.162344914912d0 + z*(-1437.2719839264719d0 + (292.8075111563232d0 - 9.978426372534301d0*z)*z))) + &
       y*(-1778.231237203896d0 + z*(4775.621344883664d0 + &
       z*(-3621.784567462512d0 + (1826.356460806092d0 - 316.49805267936244d0*z)*z)) + &
       y*(1160.5182516851419d0 + z*(-3892.3662123519d0 + &
       z*(2410.4130980405d0 + z*(-1105.446104680304d0 + 129.6381336154442d0*z))) + &
       y*(-569.531539542516d0 + y*(128.13429152494615d0 - 404.50541014508605d0*z) + &
       z*(1905.341809925355d0 + z*(-668.691951421377d0 + 245.11816254543362d0*z))))))

  g08 = x2*(1760.062705994408d0 + x*(-86.1329351956084d0 + &
        x*(-137.1145018408982d0 + y*(296.20061691375236d0 + y*(-205.67709290374563d0 + 49.9394019139016d0*y))) + &
        z*(766.116132004952d0 + z*(-108.3834525034224d0 + 51.2796974779828d0*z)) + &
        y*(-60.136422517125d0 - 2761.9195908075417d0*z + y*(10.50720794170734d0 + 2814.78225133626d0*z))) + &
        y*(-1351.605895580406d0 + y*(1097.1125373015109d0 + y*(-433.20648175062206d0 + 63.905091254154904d0*y) + &
        z*(-3572.7449038462437d0 + (896.713693665072d0 - 437.84750280190565d0*z)*z)) + &
        z*(4165.4688847996085d0 + z*(-1229.337851789418d0 + (681.370187043564d0 - 66.7696405958478d0*z)*z))) + &
        z*(-1721.528607567954d0 + z*(674.819060538734d0 + &
        z*(-356.629112415276d0 + (88.4080716616d0 - 15.84003094423364d0*z)*z))))
     
  gsw_gibbs = (g03 + g08)*0.000625d0  

elseif(ns.eq.1 .and. nt.eq.0 .and. np.eq.1) then

  g08 = -6620.98308089678d0 + z*(1539.176611914396d0 + &
        z*(-579.1945920644748d0 + (126.7265382134592d0 - 26.2480156590992d0*z)*z)) + &
        x*(598.378809221703d0 + x*(-219.1676534131548d0 + 180.142097805543d0*x - 90.6734234051316d0*y + &
        (-32.65551831298088d0 - 362.10613436539325d0*z)*z) + &
        z*(-313.764545568801d0 + (612.4004484538132d0 - 40.95023189295384d0*z)*z) + &
        y*(-525.876123559641d0 + (499.15435668109143d0 - 265.347579144861d0*z)*z + &
        y*(1149.174198007428d0 + y*(-1380.9597954037708d0 + 703.695562834065d0*y) + &
        z*(-325.1503575102672d0 + 230.7586386509226d0*z)))) + &
        y*(1458.233059470092d0 + z*(-1375.827611846244d0 + &
        z*(748.126026697488d0 + z*(-253.255715088584d0 + 70.4658803315449d0*z))) + &
        y*(-1721.528607567954d0 + y*(1388.489628266536d0 + &
        y*(-595.457483974374d0 + (298.904564555024d0 - 218.92375140095282d0*z)*z) + &
        z*(-819.558567859612d0 + (681.370187043564d0 - 89.0261874611304d0*z)*z)) + &
        z*(1349.638121077468d0 + z*(-1069.887337245828d0 + (353.6322866464d0 - 79.20015472116819d0*z)*z))))    
                                                          
  gsw_gibbs = g08*gsw_sfac*0.5d-8
         
elseif(ns.eq.0 .and. nt.eq.1 .and. np.eq.1) then

  g03 = -270.983805184062d0 + z*(1552.307223226202d0 + z*(-589.53765264366d0 + (115.91861051767d0 - 10.664504175916349d0*z)*z)) + &
        y*(2910.0729080936d0 + z*(-3026.233543077436d0 + &
        z*(1640.877973941168d0 + z*(-444.4832510537744d0 + 43.4420671917197d0*z))) + &
        y*(-2017.52334943521d0 + z*(2996.162344914912d0 + &
        z*(-2155.907975889708d0 + (585.6150223126464d0 - 24.946065931335752d0*z)*z)) + &
        y*(1591.873781627888d0 + z*(-2414.523044975008d0 + (1826.356460806092d0 - 421.9974035724832d0*z)*z) + &
        y*(-973.091553087975d0 + z*(1205.20654902025d0 + z*(-829.084578510228d0 + 129.6381336154442d0*z)) + &
        y*(381.06836198507096d0 - 67.41756835751434d0*y + z*(-267.4767805685508d0 + 147.07089752726017d0*z))))))
    
  g08 = x2*(729.116529735046d0 + z*(-687.913805923122d0 + &
        z*(374.063013348744d0 + z*(-126.627857544292d0 + 35.23294016577245d0*z))) + &
        x*(-175.292041186547d0 - 22.6683558512829d0*x + (166.3847855603638d0 - 88.449193048287d0*z)*z + &
        y*(766.116132004952d0 + y*(-1380.9597954037708d0 + 938.26075044542d0*y) + &
        z*(-216.7669050068448d0 + 153.8390924339484d0*z))) + &
        y*(-1721.528607567954d0 + y*(2082.7344423998043d0 + &
        y*(-1190.914967948748d0 + (597.809129110048d0 - 437.84750280190565d0*z)*z) + &
        z*(-1229.337851789418d0 + (1022.055280565346d0 - 133.5392811916956d0*z)*z)) + &
        z*(1349.638121077468d0 + z*(-1069.887337245828d0 + (353.6322866464d0 - 79.20015472116819d0*z)*z))))
    
  gsw_gibbs = (g03 + g08)*2.5d-10

elseif(ns.eq.0 .and. nt.eq.0 .and. np.eq.2) then
           
  g03 = -5089.1530840726d0 + z*(1707.1066706777221d0 + &
      z*(-399.7761051043332d0 + (84.0526217606168d0 - 16.39285534413117d0*z)*z)) + &
     y*(1552.307223226202d0 + z*(-1179.07530528732d0 + (347.75583155301d0 - 42.658016703665396d0*z)*z) + &
      y*(-1513.116771538718d0 + z*(1640.877973941168d0 + z*(-666.7248765806615d0 + 86.8841343834394d0*z)) + &
        y*(998.720781638304d0 + z*(-1437.2719839264719d0 + (585.6150223126464d0 - 33.261421241781d0*z)*z) + &
         y*(-603.630761243752d0 + (913.178230403046d0 - 316.49805267936244d0*z)*z + &
           y*(241.04130980405d0 + y*(-44.5794634280918d0 + 49.023632509086724d0*z) + &
            z*(-331.6338314040912d0 + 77.78288016926652d0*z))))))
            
  g08 = x2*(769.588305957198d0 + z*(-579.1945920644748d0 + (190.08980732018878d0 - 52.4960313181984d0*z)*z) + &
      x*(-104.588181856267d0 + x*(-8.16387957824522d0 - 181.05306718269662d0*z) + &
       (408.2669656358754d0 - 40.95023189295384d0*z)*z + &
       y*(166.3847855603638d0 - 176.898386096574d0*z + y*(-108.3834525034224d0 + 153.8390924339484d0*z))) + &
      y*(-687.913805923122d0 + z*(748.126026697488d0 + z*(-379.883572632876d0 + 140.9317606630898d0*z)) + &
       y*(674.819060538734d0 + z*(-1069.887337245828d0 + (530.4484299696d0 - 158.40030944233638d0*z)*z) + &
         y*(-409.779283929806d0 + y*(149.452282277512d0 - 218.92375140095282d0*z) + &
          (681.370187043564d0 - 133.5392811916956d0*z)*z))))
    
  gsw_gibbs = (g03 + g08)*1d-16 

end if

return
end function

!--------------------------------------------------------------------------
