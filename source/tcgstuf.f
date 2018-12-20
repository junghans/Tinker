c
c
c     #############################################################
c     ##  COPYRIGHT (C) 2018 by Zhi Wang and Jay William Ponder  ##
c     ##                   All Rights Reserved                   ##
c     #############################################################
c
c     ###########################################################
c     ##                                                       ##
c     ##  subroutine induce0b  --  truncated CG dipole solver  ##
c     ##                                                       ##
c     ###########################################################
c
c
c     "induce0b" computes and stores the induced dipoles via
c     the truncated conjugate gradient (TCG) method
c
c
      subroutine induce0b
      use poltcg
      implicit none
c
c
c     choose the options for computation of TCG induced dipoles
c
      if (tcgguess) then
         if (tcgprec) then
c           call induce1a
            call induce1ax
         else
            call induce1b
         end if
      else
         if (tcgprec) then
c           call induce1c
            call induce1cx
         else
            call induce1d
         end if
      end if
      return
      end
c
c
c     #################################################################
c     ##                                                             ##
c     ##  subroutine induce1a  -- TCG direct guess and precondition  ##
c     ##                                                             ##
c     #################################################################
c
c
c     "induce1a" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with initial
c     guess mu0 = direct and diagonal preconditioner = true
c
c
      subroutine induce1a
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j
      integer order
      real*8 sp0(2),spp1(2)
      real*8 sp1(2),spp2(2)
      real*8 n0(2),n1(2)
      real*8 np1(2),nrsd1(2)
      real*8 b1(2),b2(2)
      real*8 t1(2),t2(2)
      real*8 t3(2),t4(2)
      real*8 t8(2),t9(2)
      real*8 t10(2)
      real*8 beta1(2),gamma1(2)
      real*8 a110(2),a111(2)
      real*8 a112(2),a121(2)
      real*8 a1k10a(2),a1k11a(2)
      real*8 a1k11(2),a1k12(2)
      real*8 a1k20a(2),a1k21(2)
      real*8 a210(2),a21n1(2)
      real*8 a211(2),a212(2)
      real*8 a213(2),a214(2)
      real*8 a220(2),a221(2)
      real*8 a222(2),a223(2)
      real*8 a231(2),a232(2)
      real*8 a241(2),a2k10a(2)
      real*8 a2k11a(2),a2k12a(2)
      real*8 a2k11(2),a2k12(2)
      real*8 a2k13(2),a2k14(2)
      real*8 a2k20a(2),a2k21a(2)
      real*8 a2k21(2),a2k22(2)
      real*8 a2k23(2),a2k30a(2)
      real*8 a2k31(2),a2k32(2)
      real*8 a2k41(2)
      real*8 a2kwt2(2),a2kwg1(2)
      real*8, allocatable :: field(:,:,:)
      real*8, allocatable :: xde(:,:,:)
      real*8, allocatable :: xdr0(:,:,:)
      real*8, allocatable :: r0(:,:,:)
      real*8, allocatable :: m0(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: r1(:,:,:)
      real*8, allocatable :: t2m0(:,:,:)
      real*8, allocatable :: t3m0(:,:,:)
      logical converge
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based upon the tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation of some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
c
c     perform dynamic allocation of some local arrays
c
      allocate (field(3,n,2))
      allocate (xde(3,n,2))
      allocate (xdr0(3,n,2))
      allocate (r0(3,n,2))
      allocate (m0(3,n,2))
      allocate (p1(3,n,2))
      allocate (r1(3,n,2))
      allocate (t2m0(3,n,2))
      allocate (t3m0(3,n,2))
c
c     get the electrostatic field due to permanent multipoles
c     and mu0 = alpha.E
c
      if (use_ewald) then
         call dfield0c (field(:,:,1),field(:,:,2))
      else if (use_mlist) then
         call dfield0b (field(:,:,1),field(:,:,2))
      else
         call dfield0a (field(:,:,1),field(:,:,2))
      end if
      call tcg_alpha22 (field(:,:,1),field(:,:,2),udir,udirp)
      uind = udir
      uinp = udirp
c
c     r0 = -Tu.mu0
c
      if (use_ewald) then
         call ufield0c (r0(:,:,1),r0(:,:,2))
      else if (use_mlist) then
         call ufield0b (r0(:,:,1),r0(:,:,2))
      else
         call ufield0a (r0(:,:,1),r0(:,:,2))
      end if
c
c     m0 = M.r0, M is the preconditioner matrix
c     n0 = r0.m0
c
      call tcg_alpha22 (r0(:,:,1),r0(:,:,2),m0(:,:,1),m0(:,:,2))
      call tcg_dotprod (n0(1),3*npole,r0(:,:,1),m0(:,:,1))
      call tcg_dotprod (n0(2),3*npole,r0(:,:,2),m0(:,:,2))
c
c     compute tcg1 intermediates
c     p1 = T.m0 = T.M.r0
c     t1 = m0.T.m0
c     (t4 or gamma0) = r0/t1
c
      call tcg_t0 (m0(:,:,1),m0(:,:,2),p1(:,:,1),p1(:,:,2))
      call tcg_dotprod (t1(1),3*npole,m0(:,:,1),p1(:,:,1))
      call tcg_dotprod (t1(2),3*npole,m0(:,:,2),p1(:,:,2))
      t4(1) = n0(1) / t1(1)
      t4(2) = n0(2) / t1(2)
c
c     mu1 = mu0 + gamma0 * p0 (or m0)
c
      uind = uind + t4(1) * m0(:,:,1)
      uinp = uinp + t4(2) * m0(:,:,2)
c
c     r1 = r0 - gamma0 * T.p0 (or T.m0)
c
      r1(:,:,1) = r0(:,:,1) - t4(1)*p1(:,:,1)
      r1(:,:,2) = r0(:,:,2) - t4(2)*p1(:,:,2)
c
c     check convergence, stop at tcg1 level if n1 is small enough
c
      call tcg_dotprod (nrsd1(1),3*npole,r1(:,:,1),r1(:,:,1))
      call tcg_dotprod (nrsd1(2),3*npole,r1(:,:,2),r1(:,:,2))
      call tcg_converge (converge,nrsd1(1),nrsd1(2))
      if (converge) then
         order = 1
         call tcg_resource (order)
      end if
c
c     n1 = r1.M.r1
c
      call tcg_alphaquad (n1(1),r1(:,:,1),r1(:,:,1))
      call tcg_alphaquad (n1(2),r1(:,:,2),r1(:,:,2))
c
c     cross terms
c     sp0 = m0.E
c     spp1 = m0.T.alpha.E = m0.T.mu0
c
      call tcg_dotprod (sp0(1),3*npole,m0(:,:,1),field(:,:,2))
      call tcg_dotprod (sp0(2),3*npole,m0(:,:,2),field(:,:,1))
      call tcg_dotprod (spp1(1),3*npole,p1(:,:,1),udirp)
      call tcg_dotprod (spp1(2),3*npole,p1(:,:,2),udir)
c
c     tcg1 force and energy
c
      if (order .eq. 1) then
c
c     compute a(1) coefficients: a1...
c     and a(1k) coefficients: a1k...
c
         do i = 1, 2
            a110(i) = t4(i)
            a111(i) = 2.0d0 * sp0(i) / t1(i)
            a112(i) = -t4(i) * a111(i)
            a121(i) = 0.5d0 * a112(i)
            a1k10a(i) = tcgpeek
            a1k11a(i) = -tcgpeek * t4(i)
            a1k11(i) = -2.0d0 * spp1(i) * tcgpeek / t1(i)
            a1k12(i) = -t4(i) * a1k11(i)
            a1k20a(i) = a1k11a(i)
            a1k21(i) = 0.5d0 * a1k12(i)
         end do
c
c     mu1(peek) = mu1 + omega * alpha.r1
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = 0.5d0 * (-(a121(1)+a1k21(1))*m0(:,:,1)
     &                            - a1k20a(1)*udirp)
         ubd(:,:,1) = 0.5d0 * (-(a121(2)+a1k21(2))*m0(:,:,2)
     &                            - a1k20a(2)*udir)
         xdr0(:,:,1) = (a110(2)+a1k11a(2)+a1k10a(2))*field(:,:,1)
     &                  - a1k11a(2)*r0(:,:,1)
     &                  + (a111(2)+a1k11(2))*r0(:,:,2)
     &                  + (a112(2)+a1k12(2))*p1(:,:,2)
         xdr0(:,:,2) = (a110(1)+a1k11a(1)+a1k10a(1))*field(:,:,2)
     &                  - a1k11a(1)*r0(:,:,2)
     &                  + (a111(1)+a1k11(1))*r0(:,:,1)
     &                  + (a112(1)+a1k12(1))*p1(:,:,1)
         call tcg_alpha12 (xdr0(:,:,1),xdr0(:,:,2))
c
c     xde: rhs array in <E' xde>
c     xde = mu + mu0 + alpha.(-Tu.x)
c
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),xde(:,:,1),xde(:,:,2))
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind + udir)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp + udirp)
         ubp(:,:,2) = 0.5d0 * xdr0(:,:,2)
         ubd(:,:,2) = 0.5d0 * xdr0(:,:,1)
         uad(:,:,1) = m0(:,:,1)
         uap(:,:,1) = m0(:,:,2)
         uad(:,:,2) = udir
         uap(:,:,2) = udirp
         goto 10
      end if
c
c     compute tcg2 intermediates, use "xde" as temporary storage
c     t2m0 = T.M.T.M.r0 = T.M.p1
c     t3m0 = T.(M.T)^2.M.r0 = T.M.t2m0
c     t9 = r0.M.T.M.T.M.T.M.r0 = t2m0.M.p1
c
      call tcg_alpha22 (p1(:,:,1),p1(:,:,2),xde(:,:,1),xde(:,:,2))
      call tcg_t0 (xde(:,:,1),xde(:,:,2),t2m0(:,:,1),t2m0(:,:,2))
      call tcg_alpha22 (t2m0(:,:,1),t2m0(:,:,2),xde(:,:,1),xde(:,:,2))
      call tcg_t0 (xde(:,:,1),xde(:,:,2),t3m0(:,:,1),t3m0(:,:,2))
      call tcg_alphaquad (t9(1),t2m0(:,:,1),p1(:,:,1))
      call tcg_alphaquad (t9(2),t2m0(:,:,2),p1(:,:,2))
c
c     beta1 = r1.r1/r0.r0 = n1/n0
c     t2 = 1 + beta1
c
      beta1(1) = n1(1) / n0(1)
      beta1(2) = n1(2) / n0(2)
      t2(1) = 1.0d0 + beta1(1)
      t2(2) = 1.0d0 + beta1(2)
c
c     np1 = p1.M.p1
c     t8 = t2*np1 - t4*t9
c     t10 = t1^2 - n0.|p1|^2
c     t3  = t1*t8
c     gamma1 = t10/t3
c
      call tcg_alphaquad (np1(1),p1(:,:,1),p1(:,:,1))
      call tcg_alphaquad (np1(2),p1(:,:,2),p1(:,:,2))
      t8(1) = t2(1)*np1(1) - t4(1)*t9(1)
      t8(2) = t2(2)*np1(2) - t4(2)*t9(2)
      t10(1) = t1(1)**2 - n0(1)*np1(1)
      t10(2) = t1(2)**2 - n0(2)*np1(2)
      t3(1) = t1(1)*t8(1)
      t3(2) = t1(2)*t8(2)
      gamma1(1) = t10(1) / t3(1)
      gamma1(2) = t10(2) / t3(2)
c
c     mu2 = mu1 + gamma1*p1 = mu1 + gamma1*(M.r1 + beta1*p0)
c         = mu1 + gamma1*(t2*p0 - t4*M.T.p0)
c         = mu1 + gamma1*(t2*M.r0 - t4*M.T.M.r0)
c         = mu1 + gamma1*M.(t2*r0 - t4*p1)
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = uind(j,i) + (t2(1)*r0(j,i,1) - t4(1)*p1(j,i,1))
     &                     * gamma1(1) * polarity(i)
            uinp(j,i) = uinp(j,i) + (t2(2)*r0(j,i,2) - t4(2)*p1(j,i,2))
     &                     * gamma1(2) * polarity(i)
         end do
      end do
c
c     r2 = r1 - gamma1 * T.p1 = r1 - gamma1 * p2
c        = r1 - gamma1 * (t2*T.M.r0 - t4*T.M.T.M.r0)
c        = r1 - gamma1 * (t2*p1 - t4*t2m0)
c     reuse r1 as r2
c
      r1(:,:,1) = r1(:,:,1)
     &               - gamma1(1)*(t2(1)*p1(:,:,1)-t4(1)*t2m0(:,:,1))
      r1(:,:,2) = r1(:,:,2)
     &               - gamma1(2)*(t2(2)*p1(:,:,2)-t4(2)*t2m0(:,:,2))
c
c     cross terms
c     sp1 = m0.T.M.E = p1.M.E
c     b1 = sp0 - gamma1*sp1
c     b2 = sp0*t2 - t4*sp1
c     spp2 = r0.M.T.M.T.alpha.E = p1.M.(E-r0)
c          = p1.M.E - p1.M.r0 = sp1 - p1.M.r0
c
      call tcg_alphaquad (sp1(1),p1(:,:,1),field(:,:,2))
      call tcg_alphaquad (sp1(2),p1(:,:,2),field(:,:,1))
      b1(1) = sp0(1) - gamma1(1)*sp1(1)
      b1(2) = sp0(2) - gamma1(2)*sp1(2)
      b2(1) = sp0(1)*t2(1) - t4(1)*sp1(1)
      b2(2) = sp0(2)*t2(2) - t4(2)*sp1(2)
      call tcg_alphaquad (spp2(1),p1(:,:,1),r0(:,:,2))
      call tcg_alphaquad (spp2(2),p1(:,:,2),r0(:,:,1))
      spp2(1) = sp1(1) - spp2(1)
      spp2(2) = sp1(2) - spp2(2)
c
c     tcg2 force and energy
c
      if (order .eq. 2) then
c
c     compute a(2) coefficients: a2...
c     and a(2k) coefficients: a2k...
c
         do i = 1, 2
            a232(i) = t1(i)*t4(i)*gamma1(i)*b2(i)/t3(i)
            a241(i) = a232(i)
            a231(i) = -n0(i)*b2(i)/t3(i)
     &                -2.0d0*t1(i)*t2(i)*gamma1(i)*b2(i)/t3(i)
     &                +t4(i)*gamma1(i)*sp0(i)/t1(i)
            a223(i) = a232(i)
            a222(i) = a231(i)
            a221(i) = -t4(i)*b1(i)/t1(i) +2.0d0*t1(i)*b2(i)/t3(i)
     &                -t4(i)*t9(i)*gamma1(i)*b2(i)/t3(i)
     &                +2.0d0*t2(i)*np1(i)*gamma1(i)*b2(i)/t3(i)
     &                -t8(i)*gamma1(i)*b2(i)/t3(i)
     &                -2.0d0*t4(i)*np1(i)*sp0(i)*gamma1(i)/(t1(i)**2)
            a220(i) = -gamma1(i)*t4(i)
            a214(i) = 2.0d0*a232(i)
            a213(i) = 2.0d0*a231(i)
            a212(i) = 2.0d0*a221(i)
            a211(i) = 2.0d0*(b1(i)/t1(i) -np1(i)*b2(i)/t3(i)
     &                   -(np1(i)**2)*gamma1(i)*b2(i)/t3(i)/t1(i)
     &                   +t9(i)*gamma1(i)*b2(i)/t3(i)
     &                   +np1(i)*sp0(i)*gamma1(i)/(t1(i)**2))
            a21n1(i) = a220(i)
            a210(i) = t4(i) + gamma1(i)*t2(i)
            a2kwt2(i) = tcgpeek*(t2(i)*spp1(i)-t4(i)*spp2(i))
            a2kwg1(i) = tcgpeek*(spp1(i)-gamma1(i)*spp2(i))
            a2k41(i) = -a2kwt2(i)*t1(i)*t4(i)*gamma1(i)/t3(i)
            a2k32(i) = a2k41(i)
            a2k31(i) = -tcgpeek*t4(i)*gamma1(i)*spp1(i)/t1(i)
     &                    +a2kwt2(i)*(n0(i)/t3(i)
     &                    +2.0d0*t1(i)*t2(i)*gamma1(i)/t3(i))
            a2k30a(i) = tcgpeek*gamma1(i)*t4(i)
            a2k23(i) = a2k41(i)
            a2k22(i) = a2k31(i)
            a2k21(i) = 2.0d0*t4(i)*np1(i)/(t1(i)**2)*
     &                       tcgpeek*gamma1(i)*spp1(i)
     &                    +a2kwt2(i)*(-2.0d0*t1(i)+
     &                       (t4(i)*t9(i)-2.0d0*np1(i)*t2(i)+t8(i))*
     &                       gamma1(i))/t3(i)
     &                    +t4(i)*a2kwg1(i)/t1(i)
            a2k21a(i) = a2k30a(i)
            a2k20a(i) = -tcgpeek*(gamma1(i)*t2(i)+t4(i))
            a2k14(i) = 2.0d0*a2k41(i)
            a2k13(i) = 2.0d0*a2k22(i)
            a2k12(i) = 2.0d0*a2k21(i)
            a2k11(i) = -np1(i)/(t1(i)**2)*tcgpeek*gamma1(i)*spp1(i)
     &                    +a2kwt2(i)*(np1(i)
     &                       +(np1(i)**2)*gamma1(i)/t1(i)
     &                       -t9(i)*gamma1(i))/t3(i)
     &                    -a2kwg1(i)/t1(i)
            a2k11(i) = 2.0d0*a2k11(i)
            a2k12a(i) = a2k30a(i)
            a2k11a(i) = a2k20a(i)
            a2k10a(i) = tcgpeek
         end do
c
c     mu2(peek) = mu2 + omega * alpha.r2
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = 0.5d0 * (-(a220(1)+a2k20a(1)
     &                            +a2k21a(1))*field(:,:,2)
     &                            +a2k21a(1)*r0(:,:,2)
     &                            -(a221(1)+a2k21(1))*r0(:,:,1)
     &                            -(a222(1)+a231(1)+a2k22(1)
     &                                 +a2k31(1))*p1(:,:,1)
     &                            -(a223(1)+a241(1)+a2k23(1)
     &                                 +a2k41(1))*t2m0(:,:,1))
         ubd(:,:,1) = 0.5d0 * (-(a220(2)+a2k20a(2)
     &                            +a2k21a(2))*field(:,:,1)
     &                            +a2k21a(2)*r0(:,:,1)
     &                            -(a221(2)+a2k21(2))*r0(:,:,2)
     &                            -(a222(2)+a231(2)+a2k22(2)
     &                                 +a2k31(2))*p1(:,:,2)
     &                            -(a223(2)+a241(2)+a2k23(2)
     &                                 +a2k41(2))*t2m0(:,:,2))
         ubp(:,:,2) = 0.5d0 * (-(a232(1)+a2k32(1))*p1(:,:,1)
     &                            -a2k30a(1)*field(:,:,2))
         ubd(:,:,2) = 0.5d0 * (-(a232(2)+a2k32(2))*p1(:,:,2)
     &                            -a2k30a(2)*field(:,:,1))
         xdr0(:,:,1) = (a210(2)+a21n1(2)+a2k10a(2)
     &                     +a2k11a(2)+a2k12a(2))*field(:,:,1)
     &               - (a21n1(2)+a2k11a(2)+a2k12a(2))*r0(:,:,1)
     &               + (a211(2)+a2k11(2))*r0(:,:,2)
     &               - a2k12a(2)*p1(:,:,1)
     &               + (a212(2)+a2k12(2))*p1(:,:,2)
     &               + (a213(2)+a2k13(2))*t2m0(:,:,2)
     &               + (a214(2)+a2k14(2))*t3m0(:,:,2)
         xdr0(:,:,2) = (a210(1)+a21n1(1)+a2k10a(1)
     &                     +a2k11a(1)+a2k12a(1))*field(:,:,2)
     &               - (a21n1(1)+a2k11a(1)+a2k12a(1))*r0(:,:,2)
     &               + (a211(1)+a2k11(1))*r0(:,:,1)
     &               - a2k12a(1)*p1(:,:,2)
     &               + a212(1)*p1(:,:,1)+a2k12(1)*p1(:,:,1)
     &               + (a213(1)+a2k13(1))*t2m0(:,:,1)
     &               + (a214(1)+a2k14(1))*t3m0(:,:,1)
         call tcg_alpha12 (xdr0(:,:,1),xdr0(:,:,2))
c
c     xde = mu + mu0 + alpha.(-Tu.x)
c
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),xde(:,:,1),xde(:,:,2))
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind + udir)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp + udirp)
         call tcg_alpha12 (ubp(:,:,1),ubd(:,:,1))
         call tcg_alpha12 (ubp(:,:,2),ubd(:,:,2))
         ubp(:,:,3) = 0.5d0 * xdr0(:,:,2)
         ubd(:,:,3) = 0.5d0 * xdr0(:,:,1)
         uad(:,:,1) = m0(:,:,1)
         uap(:,:,1) = m0(:,:,2)
         call tcg_alpha22 (p1(:,:,1),p1(:,:,2),uad(:,:,2),uap(:,:,2))
         uad(:,:,3) = udir
         uap(:,:,3) = udirp
         goto 10
      end if
c
c     store induced dipoles from elements of the xde arrays
c
   10 continue
      uind = xde(:,:,1)
      uinp = xde(:,:,2)
c
c     perform deallocation of some local arrays
c
      deallocate (field)
      deallocate (xde)
      deallocate (xdr0)
      deallocate (r0)
      deallocate (m0)
      deallocate (p1)
      deallocate (r1)
      deallocate (t2m0)
      deallocate (t3m0)
      return
      end
c
c
c     ###################################################################
c     ##                                                               ##
c     ##  subroutine induce1ax  --  TCG direct guess and precondition  ##
c     ##                                                               ##
c     ###################################################################
c
c
c     "induce1ax" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with dp
c     cross terms = true, initial guess mu0 = direct and diagonal
c     preconditioner = true
c
c
      subroutine induce1ax
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j,order
      real*8 chi,xi0,xi1
      real*8 n0,np0,g0
      real*8 n1,beta1,np1,g1
      real*8 n2,beta2,np2,g2
      real*8 n3,beta3
      real*8 a100,a101,a102,a103,b111
      real*8 c100,c101,c102,d111
      real*8 c200,c201,c202,c203,c204
      real*8 d210,d211,d212,d213,d222
      real*8, allocatable :: xdr0(:,:,:)
      real*8, allocatable :: rsd(:,:,:)
      real*8, allocatable :: p0(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: p2(:,:,:)
      real*8, allocatable :: p3(:,:,:)
      real*8, allocatable :: tp(:,:,:)
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based on tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation for some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
      uad = 0.0d0
      uap = 0.0d0
      ubd = 0.0d0
      ubp = 0.0d0
c
c     perform dynamic allocation for some local arrays
c
      allocate (xdr0(3,n,2))
      allocate (rsd(3,n,2))
      allocate (p0(3,n,2))
      allocate (p1(3,n,2))
      allocate (p2(3,n,2))
      allocate (p3(3,n,2))
      allocate (tp(3,n,2))
      xdr0 = 0.0d0
c
c     chi = omega - 1
c
      chi = tcgpeek - 1.0d0
c
c     get the electrostatic field due to permanent multipoles
c     and mu0 = alpha.E
c     use variable tp to store the multipole field
c
      if (use_ewald) then
         call dfield0c (tp(:,:,1),tp(:,:,2))
      else if (use_mlist) then
         call dfield0b (tp(:,:,1),tp(:,:,2))
      else
         call dfield0a (tp(:,:,1),tp(:,:,2))
      end if
      call tcg_alpha22 (tp(:,:,1),tp(:,:,2),udir,udirp)
c
c     compute tcg1 intermediates
c     r0 = -Tu.mu0
c     n0 = r0.a.r0
c     p0 = a.r0
c     xi0
c     np0 = p0.T.p0
c     g0
c
      call tcg_ufield (udir,udirp,rsd(:,:,1),rsd(:,:,2))
      call tcg_alphaquad (n0,rsd(:,:,1),rsd(:,:,2))
      call tcg_alpha22 (rsd(:,:,1),rsd(:,:,2),p0(:,:,1),p0(:,:,2))
      call tcg_dotprod (xi0,3*npole,rsd(:,:,1),udirp)
      xi0 = xi0 / n0
      call tcg_t0 (p0(:,:,1),p0(:,:,2),tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np0,3*npole,tp(:,:,1),p0(:,:,2))
      g0 = n0 / np0
c
c     r1 = r0 - g0 T.p0
c     n1, beta1
c
      rsd = rsd - g0 * tp
      call tcg_alphaquad (n1,rsd(:,:,1),rsd(:,:,2))
      beta1 = n1 / n0
c
c     p1 <- r1, p0
c
      p1 = p0
      call tcg_update_pvec (p1(:,:,1),rsd(:,:,1),beta1)
      call tcg_update_pvec (p1(:,:,2),rsd(:,:,2),beta1)
c
c     "Residual Mutual 1"
c     ua(1) <- mu0
c     ua(2) <- mu1 = g0 * p0
c     ub(2) <- p0
c     xdr0 <- p0, p1
c
      uad(:,:,1) = udir
      uap(:,:,1) = udirp
      ubd(:,:,1) = ubd(:,:,1) + 0.5d0*udir
      ubp(:,:,1) = ubp(:,:,1) + 0.5d0*udirp
      uad(:,:,2) = g0*p0(:,:,1)
      uap(:,:,2) = g0*p0(:,:,2)
      ubd(:,:,2) = ubd(:,:,2) + 0.5d0*g0*p0(:,:,1)
      ubp(:,:,2) = ubp(:,:,2) + 0.5d0*g0*p0(:,:,2)
      xdr0 = xdr0 + g0*(1.0d0-beta1)*p0 + g0*p1
c
c     tcg1 force and energy
c     tp array works as xde array
c
      if (order .eq. 1) then
         c100 = 0.5d0*(1.0d0-g0)
         c101 = (0.5d0 - beta1*(1.0d0-xi0))*g0
         c102 = g0*(1.0d0-xi0)
         d111 = 0.5d0*(1.0d0-xi0)*g0
         xdr0(:,:,1) = xdr0(:,:,1) + chi*(c100*udir
     &                  + c101*p0(:,:,1) + c102*p1(:,:,1))
         xdr0(:,:,2) = xdr0(:,:,2) + chi*(c100*udirp
     &                  + c101*p0(:,:,2) + c102*p1(:,:,2))
         ubd(:,:,1) = ubd(:,:,1) + xdr0(:,:,1)
         ubp(:,:,1) = ubp(:,:,1) + xdr0(:,:,2)
         ubd(:,:,2) = ubd(:,:,2) + chi*(d111*p0(:,:,1)+0.5d0*udir)
         ubp(:,:,2) = ubp(:,:,2) + chi*(d111*p0(:,:,2)+0.5d0*udirp)
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),tp(:,:,1),tp(:,:,2))
         call tcg_alpha12 (tp(:,:,1),tp(:,:,2))
         tp(:,:,1) = tp(:,:,1) + chi*0.5d0*p1(:,:,1)
     &             + (1.0d0-chi*beta1*0.5d0)*p0(:,:,1) + udir
         tp(:,:,2) = tp(:,:,2) + chi*0.5d0*p1(:,:,2)
     &             + (1.0d0-chi*beta1*0.5d0)*p0(:,:,2) + udirp
         goto 10
      end if
c
c     compute tcg2 intermediates
c     xi1, np1, g1
c
      call tcg_dotprod (xi1,3*npole,rsd(:,:,1),udirp)
      xi1 = xi1 / n1 + xi0
      call tcg_t0 (p1(:,:,1),p1(:,:,2),tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np1,3*npole,tp(:,:,1),p1(:,:,2))
      g1 = n1 / np1
c
c     r2 = r1 - g1 * T.p1
c     n2, beta2
c     p2 <- r2, p1
c     np2, g2
c
      rsd = rsd - g1 * tp
      call tcg_alphaquad (n2,rsd(:,:,1),rsd(:,:,2))
      beta2 = n2 / n1
      p2 = p1
      call tcg_update_pvec (p2(:,:,1),rsd(:,:,1),beta2)
      call tcg_update_pvec (p2(:,:,2),rsd(:,:,2),beta2)
      call tcg_t0 (p2(:,:,1),p2(:,:,2),tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np2,3*npole,tp(:,:,1),p2(:,:,2))
      g2 = n2/np2
c
c     r3 = r2 - g2 * T.p2
c     n3, beta3
c     p3 <- r3, p2
c
      rsd = rsd - g2 * tp
      call tcg_alphaquad (n3,rsd(:,:,1),rsd(:,:,2))
      beta3 = n3 / n2
      p3 = p2
      call tcg_update_pvec (p3(:,:,1),rsd(:,:,1),beta3)
      call tcg_update_pvec (p3(:,:,2),rsd(:,:,2),beta3)
c
c     "Residual Mutual 2"
c     ub(2) <- p1, p2
c     ua(3) <- mu2 = g1 * p1
c     ub(3) <- p1
c     xdr0 <- p0, p1, p2, p3
c
      b111 = (1.0d0-beta2) * g1
      a103 = g0*g1/g2
      a102 = (1.0d0-beta2)*g0 + (1.0d0+beta1)*g1 - (1.0d0+beta3)*a103
      a101 = (beta2**2-1.0d0)*g0 + (1.0d0-beta2-beta1*beta2)*g1
     &          + beta2*a103
      a100 = (1.0d0-beta2)*g0*beta1
      ubd(:,:,2) = ubd(:,:,2)+ b111*p1(:,:,1) + g1*p2(:,:,1)
      ubp(:,:,2) = ubp(:,:,2)+ b111*p1(:,:,2) + g1*p2(:,:,2)
      uad(:,:,3) = g1*p1(:,:,1)
      uap(:,:,3) = g1*p1(:,:,2)
      ubd(:,:,3) = ubd(:,:,3) + 0.5d0*g1*p1(:,:,1)
      ubp(:,:,3) = ubp(:,:,3) + 0.5d0*g1*p1(:,:,2)
      xdr0 = xdr0 + a100*p0 + a101*p1 + a102*p2 + a103*p3
c
c     tcg2 force and energy
c     tp array works as xde array
c
      if (order .eq. 2) then
         c200 = 0.5d0*((1.0d0-g0)*(1.0d0-g1)-beta1*g1)
         c201 = 0.5d0*(1.0d0-g1)*g0 + (xi0-xi1)*g1*beta1**2
     &             + (xi1-1.0d0)*beta1*beta2*g0
     &             + (xi0+g0-xi0*g0)*beta1*g1
         c202 = 0.5d0*g1 + (1.0d0-xi1)*beta2*g0*g1/g2
     &             + (1.0d0-xi1)*(beta2*g0-(1.0d0+beta1)*g1)*beta2
     &             + (xi0*g0-xi0-g0)*g1 + (beta2*g0-beta1*g1)*(xi0-xi1)
         c203 = (xi1-1.0d0)*(1.0d0+beta3)*g0*g1/g2
     &             + (g1+beta1*g1-beta2*g0)*(1.0d0-xi1) + (1.0d0-xi0)*g0
         c204 = (1.0d0-xi1)*g0*g1/g2
         d210 = 0.5d0*(1.0d0-g1)
         d211 = 0.5d0*(1.0d0-xi0)*(1.0d0-g1)*g0
         d212 = ((1.0d0-xi0)-(1.0d0-xi1)*beta2)*g1
         d213 = (1.0d0-xi1)*g1
         d222 = 0.5d0*d213
         xdr0(:,:,1) = xdr0(:,:,1) + chi*(c204*p3(:,:,1)
     &               + c203*p2(:,:,1) + c202*p1(:,:,1)
     &               + c201*p0(:,:,1) + c200*udir)
         xdr0(:,:,2) = xdr0(:,:,2) + chi*(c204*p3(:,:,2)
     &               + c203*p2(:,:,2) + c202*p1(:,:,2)
     &               + c201*p0(:,:,2) + c200*udirp)
         ubd(:,:,1) = ubd(:,:,1) + xdr0(:,:,1)
         ubp(:,:,1) = ubp(:,:,1) + xdr0(:,:,2)
         ubd(:,:,2) = ubd(:,:,2) + chi*(d213*p2(:,:,1) + d212*p1(:,:,1)
     &              + d211*p0(:,:,1) + d210*udir)
         ubp(:,:,2) = ubp(:,:,2) + chi*(d213*p2(:,:,2) + d212*p1(:,:,2)
     &              + d211*p0(:,:,2) + d210*udirp)
         ubd(:,:,3) = ubd(:,:,3) + chi*(d222*p1(:,:,1) + 0.5d0*udir)
         ubp(:,:,3) = ubp(:,:,3) + chi*(d222*p1(:,:,2) + 0.5d0*udirp)
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),tp(:,:,1),tp(:,:,2))
         call tcg_alpha12 (tp(:,:,1),tp(:,:,2))
         tp(:,:,1) = tp(:,:,1) + p0(:,:,1) + udir
     &             + chi*0.5d0*(p2(:,:,1)-beta2*p1(:,:,1))
         tp(:,:,2) = tp(:,:,2) + p0(:,:,2) + udirp
     &             + chi*0.5d0*(p2(:,:,2)-beta2*p1(:,:,2))
         goto 10
      end if
c
c     store induced dipoles from elements of the xde arrays
c
   10 continue
      uind = tp(:,:,1)
      uinp = tp(:,:,2)
c
c     perform deallocation for some local arrays
c
      deallocate (xdr0)
      deallocate (rsd)
      deallocate (p0)
      deallocate (p1)
      deallocate (p2)
      deallocate (p3)
      deallocate (tp)
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine induce1b  -- TCG direct guess & no precondition  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "induce1b" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with initial
c     guess mu0 = direct and diagonal preconditioner = false
c
c
      subroutine induce1b
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j
      integer order
      real*8 sp0(2),spp1(2)
      real*8 sp1(2),spp2(2)
      real*8 n0(2),n1(2)
      real*8 np1(2)
      real*8 b1(2),b2(2)
      real*8 t1(2),t2(2)
      real*8 t3(2),t4(2)
      real*8 t8(2),t9(2)
      real*8 t10(2)
      real*8 beta1(2),gamma1(2)
      real*8 a110(2),a111(2)
      real*8 a112(2),a121(2)
      real*8 a1k10a(2),a1k11a(2)
      real*8 a1k11(2),a1k12(2)
      real*8 a1k20a(2),a1k21(2)
      real*8 a210(2),a21n1(2)
      real*8 a211(2),a212(2)
      real*8 a213(2),a214(2)
      real*8 a220(2),a221(2)
      real*8 a222(2),a223(2)
      real*8 a231(2),a232(2)
      real*8 a241(2),a2k10a(2)
      real*8 a2k11a(2),a2k12a(2)
      real*8 a2k11(2),a2k12(2)
      real*8 a2k13(2),a2k14(2)
      real*8 a2k20a(2),a2k21a(2)
      real*8 a2k21(2),a2k22(2)
      real*8 a2k23(2),a2k30a(2)
      real*8 a2k31(2),a2k32(2)
      real*8 a2k41(2)
      real*8 a2kwt2(2),a2kwg1(2)
      real*8, allocatable :: field(:,:,:)
      real*8, allocatable :: xde(:,:,:)
      real*8, allocatable :: xdr0(:,:,:)
      real*8, allocatable :: r0(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: r1(:,:,:)
      real*8, allocatable :: t2r0(:,:,:)
      real*8, allocatable :: t3r0(:,:,:)
      real*8, allocatable :: te(:,:,:)
      logical converge
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based upon the tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation of some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
c
c     perform dynamic allocation of some local arrays
c
      allocate (field(3,n,2))
      allocate (xde(3,n,2))
      allocate (xdr0(3,n,2))
      allocate (r0(3,n,2))
      allocate (p1(3,n,2))
      allocate (r1(3,n,2))
      allocate (t2r0(3,n,2))
      allocate (t3r0(3,n,2))
      allocate (te(3,n,2))
c
c     get the electrostatic field due to permanent multipoles
c
      if (use_ewald) then
         call dfield0c (field(:,:,1),field(:,:,2))
      else if (use_mlist) then
         call dfield0b (field(:,:,1),field(:,:,2))
      else
         call dfield0a (field(:,:,1),field(:,:,2))
      end if
c
c     mu0 = alpha.E
c
      call tcg_alpha22 (field(:,:,1),field(:,:,2),udir,udirp)
      uind = udir
      uinp = udirp
c
c     r0 = -Tu.mu0 = mutual field of mu0
c
      if (use_ewald) then
         call ufield0c (r0(:,:,1),r0(:,:,2))
      else if (use_mlist) then
         call ufield0b (r0(:,:,1),r0(:,:,2))
      else
         call ufield0a (r0(:,:,1),r0(:,:,2))
      end if
c
c     n0 = r0.r0
c
      call tcg_dotprod (n0(1),3*npole,r0(:,:,1),r0(:,:,1))
      call tcg_dotprod (n0(2),3*npole,r0(:,:,2),r0(:,:,2))
c
c     compute tcg1 intermediates
c     (p1 or t1r0) = T.r0
c     (t1 or rtr0) = r0.T.r0
c     (t4 or gamma0) = r0.r0/r0.T.r0
c
      call tcg_t0 (r0(:,:,1),r0(:,:,2),p1(:,:,1),p1(:,:,2))
      call tcg_dotprod (t1(1),3*npole,r0(:,:,1),p1(:,:,1))
      call tcg_dotprod (t1(2),3*npole,r0(:,:,2),p1(:,:,2))
      t4(1) = n0(1) / t1(1)
      t4(2) = n0(2) / t1(2)
c
c     mu1 = mu0 + gamma0 * p0 (or r0)
c
      uind = uind + t4(1) * r0(:,:,1)
      uinp = uinp + t4(2) * r0(:,:,2)
c
c     r1 = r0 - gamma0 * T.p0 (or T.r0)
c
      r1(:,:,1) = r0(:,:,1) - t4(1)*p1(:,:,1)
      r1(:,:,2) = r0(:,:,2) - t4(2)*p1(:,:,2)
c
c     n1 = r1.r1
c     check convergence, stop at tcg1 level if n1 is small enough
c
      call tcg_dotprod (n1(1),3*npole,r1(:,:,1),r1(:,:,1))
      call tcg_dotprod (n1(2),3*npole,r1(:,:,2),r1(:,:,2))
      call tcg_converge (converge,n1(1),n1(2))
      if (converge) then
         order = 1
         call tcg_resource (order)
      end if
c
c     cross terms
c     sp0 = r0.E
c     spp1 = r0.T.alpha.E = r0.T.mu0
c
      call tcg_dotprod (sp0(1),3*npole,r0(:,:,1),field(:,:,2))
      call tcg_dotprod (sp0(2),3*npole,r0(:,:,2),field(:,:,1))
      call tcg_dotprod (spp1(1),3*npole,p1(:,:,1),udirp)
      call tcg_dotprod (spp1(2),3*npole,p1(:,:,2),udir)
c
c     tcg1 force and energy
c
      if (order .eq. 1) then
c
c     compute a(1) coefficients: a1...
c     and a(1k) coefficients: a1k...
c
         do i = 1, 2
            a110(i) = t4(i)
            a111(i) = 2.0d0 * sp0(i) / t1(i)
            a112(i) = -t4(i) * a111(i)
            a121(i) = 0.5d0 * a112(i)
            a1k10a(i) = tcgpeek
            a1k11a(i) = -tcgpeek * t4(i)
            a1k11(i) = -2.0d0 * spp1(i) * tcgpeek / t1(i)
            a1k12(i) = -t4(i) * a1k11(i)
            a1k20a(i) = a1k11a(i)
            a1k21(i) = 0.5d0 * a1k12(i)
         end do
c
c     mu1(peek) = mu1 + omega * alpha.r1
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = 0.5d0 * (-(a121(1)+a1k21(1))*r0(:,:,1)
     &                            - a1k20a(1)*udirp)
         ubd(:,:,1) = 0.5d0 * (-(a121(2)+a1k21(2))*r0(:,:,2)
     &                            - a1k20a(2)*udir)
         xdr0(:,:,1) = (a110(2)+a1k11a(2))*field(:,:,1)
     &                  + a1k10a(2)*udir - a1k11a(2)*r0(:,:,1)
     &                  + (a111(2)+a1k11(2))*r0(:,:,2)
     &                  + (a112(2)+a1k12(2))*p1(:,:,2)
         xdr0(:,:,2) = (a110(1)+a1k11a(1))*field(:,:,2)
     &                  + a1k10a(1)*udirp - a1k11a(1)*r0(:,:,2)
     &                  + (a111(1)+a1k11(1))*r0(:,:,1)
     &                  + (a112(1)+a1k12(1))*p1(:,:,1)
c
c     xde: rhs array in <E' xde>
c     xde = mu + mu0 + alpha.(-Tu.x)
c
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),xde(:,:,1),xde(:,:,2))
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind + udir)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp + udirp)
         ubp(:,:,2) = 0.5d0 * xdr0(:,:,2)
         ubd(:,:,2) = 0.5d0 * xdr0(:,:,1)
         uad(:,:,1) = r0(:,:,1)
         uad(:,:,2) = udir
         uap(:,:,1) = r0(:,:,2)
         uap(:,:,2) = udirp
         goto 10
      end if
c
c     compute tcg2 intermediates
c     t2r0 = T^2.r0 = T.p1
c     t3r0 = T^3.r0
c     te = T.E
c     t9 = r0.T^3.r0 = r0.T^2.T.r0
c
      call tcg_t0 (p1(:,:,1),p1(:,:,2),t2r0(:,:,1),t2r0(:,:,2))
      call tcg_t0 (t2r0(:,:,1),t2r0(:,:,2),t3r0(:,:,1),t3r0(:,:,2))
      call tcg_t0 (field(:,:,1),field(:,:,2),te(:,:,1),te(:,:,2))
      call tcg_dotprod (t9(1),3*npole,t2r0(:,:,1),p1(:,:,1))
      call tcg_dotprod (t9(2),3*npole,t2r0(:,:,2),p1(:,:,2))
c
c     beta1 = r1.r1/r0.r0 = n1/n0
c     t2 = 1 + beta1
c
      beta1(1) = n1(1) / n0(1)
      beta1(2) = n1(2) / n0(2)
      t2(1) = 1.0d0 + beta1(1)
      t2(2) = 1.0d0 + beta1(2)
c
c     np1 = p1.p1
c     t8 = t5 = p1.T.p1 = p1.p2 = t2*np1 - t4*t9
c     t10 = t1^2 - n0.|p1|^2
c     t3 = t1*p1.p2 = t1*t8
c     gamma1 = t10/t3
c
      call tcg_dotprod (np1(1),3*npole,p1(:,:,1),p1(:,:,1))
      call tcg_dotprod (np1(2),3*npole,p1(:,:,2),p1(:,:,2))
      t8(1) = t2(1)*np1(1) - t4(1)*t9(1)
      t8(2) = t2(2)*np1(2) - t4(2)*t9(2)
      t10(1) = t1(1)**2 - n0(1)*np1(1)
      t10(2) = t1(2)**2 - n0(2)*np1(2)
      t3(1) = t1(1)*t8(1)
      t3(2) = t1(2)*t8(2)
      gamma1(1) = t10(1) / t3(1)
      gamma1(2) = t10(2) / t3(2)
c
c     mu2 = mu1 + gamma1*p1 = mu1 + gamma1*(r1 + beta1*p0)
c         = mu1 + gamma1*(r1 + beta1*r0)
c
      uind = uind + gamma1(1)*(r1(:,:,1) + beta1(1)*r0(:,:,1))
      uinp = uinp + gamma1(2)*(r1(:,:,2) + beta1(2)*r0(:,:,2))
c
c     r2 = r1 - gamma1 * T.p1 = r1 - gamma1 * p2
c        = r1 - gamma1 * (t2*p1 - t4*t2r0)
c     reuse r1 as r2
c
      r1(:,:,1) = r1(:,:,1)
     &               - gamma1(1)*(t2(1)*p1(:,:,1)-t4(1)*t2r0(:,:,1))
      r1(:,:,2) = r1(:,:,2)
     &               - gamma1(2)*(t2(2)*p1(:,:,2)-t4(2)*t2r0(:,:,2))
c
c     cross terms
c     sp1 = r0.T.E = p1.E
c     b1 = sp0 - gamma1*sp1
c     b2 = sp0*t2 - t4*sp1
c     spp2 = r0.T.T.alpha.E
c
      call tcg_dotprod (sp1(1),3*npole,p1(:,:,1),field(:,:,2))
      call tcg_dotprod (sp1(2),3*npole,p1(:,:,2),field(:,:,1))
      b1(1) = sp0(1) - gamma1(1)*sp1(1)
      b1(2) = sp0(2) - gamma1(2)*sp1(2)
      b2(1) = sp0(1)*t2(1) - t4(1)*sp1(1)
      b2(2) = sp0(2)*t2(2) - t4(2)*sp1(2)
      call tcg_dotprod (spp2(1),3*npole,t2r0(:,:,1),udirp)
      call tcg_dotprod (spp2(2),3*npole,t2r0(:,:,2),udir)
c
c     tcg2 force and energy
c
      if (order .eq. 2) then
c
c     compute a(2) coefficients: a2...
c     and a(2k) coefficients: a2k...
c
         do i = 1, 2
            a232(i) = t1(i)*t4(i)*gamma1(i)*b2(i)/t3(i)
            a241(i) = a232(i)
            a231(i) = -n0(i)*b2(i)/t3(i)
     &                -2.0d0*t1(i)*t2(i)*gamma1(i)*b2(i)/t3(i)
     &                +t4(i)*gamma1(i)*sp0(i)/t1(i)
            a223(i) = a232(i)
            a222(i) = a231(i)
            a221(i) = -t4(i)*b1(i)/t1(i) +2.0d0*t1(i)*b2(i)/t3(i)
     &                -t4(i)*t9(i)*gamma1(i)*b2(i)/t3(i)
     &                +2.0d0*t2(i)*np1(i)*gamma1(i)*b2(i)/t3(i)
     &                -t8(i)*gamma1(i)*b2(i)/t3(i)
     &                -2.0d0*t4(i)*np1(i)*sp0(i)*gamma1(i)/(t1(i)**2)
            a220(i) = -gamma1(i)*t4(i)
            a214(i) = 2.0d0*a232(i)
            a213(i) = 2.0d0*a231(i)
            a212(i) = 2.0d0*a221(i)
            a211(i) = 2.0d0*(b1(i)/t1(i) -np1(i)*b2(i)/t3(i)
     &                   -(np1(i)**2)*gamma1(i)*b2(i)/t3(i)/t1(i)
     &                   +t9(i)*gamma1(i)*b2(i)/t3(i)
     &                   +np1(i)*sp0(i)*gamma1(i)/(t1(i)**2))
            a21n1(i) = a220(i)
            a210(i) = t4(i) + gamma1(i)*t2(i)
            a2kwt2(i) = tcgpeek*(t2(i)*spp1(i)-t4(i)*spp2(i))
            a2kwg1(i) = tcgpeek*(spp1(i)-gamma1(i)*spp2(i))
            a2k41(i) = -a2kwt2(i)*t1(i)*t4(i)*gamma1(i)/t3(i)
            a2k32(i) = a2k41(i)
            a2k31(i) = -tcgpeek*t4(i)*gamma1(i)*spp1(i)/t1(i)
     &                    +a2kwt2(i)*(n0(i)/t3(i)
     &                       +2.0d0*t1(i)*t2(i)*gamma1(i)/t3(i))
            a2k30a(i) = tcgpeek*gamma1(i)*t4(i)
            a2k23(i) = a2k41(i)
            a2k22(i) = a2k31(i)
            a2k21(i) = 2.0d0*t4(i)*np1(i)/(t1(i)**2)*
     &                    tcgpeek*gamma1(i)*spp1(i)
     &                 +a2kwt2(i)*(-2.0d0*t1(i)+
     &                    (t4(i)*t9(i)-2.0d0*np1(i)*t2(i)+t8(i))*
     &                    gamma1(i))/t3(i)
     &                 +t4(i)*a2kwg1(i)/t1(i)
            a2k21a(i) = a2k30a(i)
            a2k20a(i) = -tcgpeek*(gamma1(i)*t2(i)+t4(i))
            a2k14(i) = 2.0d0*a2k41(i)
            a2k13(i) = 2.0d0*a2k22(i)
            a2k12(i) = 2.0d0*a2k21(i)
            a2k11(i) = -np1(i)/(t1(i)**2)*tcgpeek*gamma1(i)*spp1(i)
     &                 +a2kwt2(i)*(np1(i)
     &                    +(np1(i)**2)*gamma1(i)/t1(i)
     &                    -t9(i)*gamma1(i))/t3(i)
     &                 -a2kwg1(i)/t1(i)
            a2k11(i) = 2.0d0*a2k11(i)
            a2k12a(i) = a2k30a(i)
            a2k11a(i) = a2k20a(i)
            a2k10a(i) = tcgpeek
         end do
c
c     mu2(peek) = mu2 + omega * alpha.r2
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = 0.5d0 * (-(a220(1)+a2k21a(1))*field(:,:,2)
     &                -(a221(1)+a2k21(1))*r0(:,:,1)
     &                +a2k21a(1)*r0(:,:,2) -a2k20a(1)*udirp
     &                -(a222(1)+a231(1)+a2k22(1)+a2k31(1))*p1(:,:,1)
     &                -(a223(1)+a241(1)
     &                     +a2k23(1)+a2k41(1))*t2r0(:,:,1))
         ubp(:,:,2) = 0.5d0 * (-(a232(1)+a2k32(1))*p1(:,:,1)
     &                            -a2k30a(1)*udirp)
         ubd(:,:,1) = 0.5d0 * (-(a220(2)+a2k21a(2))*field(:,:,1)
     &                -(a221(2)+a2k21(2))*r0(:,:,2)
     &                +a2k21a(2)*r0(:,:,1) -a2k20a(2)*udir
     &                -(a222(2)+a231(2)+a2k22(2)+a2k31(2))*p1(:,:,2)
     &                -(a223(2)+a241(2)
     &                     +a2k23(2)+a2k41(2))*t2r0(:,:,2))
         ubd(:,:,2) = 0.5d0 * (-(a232(2)+a2k32(2))*p1(:,:,2)
     &                            -a2k30a(2)*udir)
         xdr0(:,:,1) = (a210(2)+a2k11a(2))*field(:,:,1)
     &                  + (a21n1(2)+a2k12a(2))*te(:,:,1)
     &                  + a2k10a(2)*udir - a2k11a(2)*r0(:,:,1)
     &                  - a2k12a(2)*p1(:,:,1)
     &                  + (a211(2)+a2k11(2))*r0(:,:,2)
     &                  + (a212(2)+a2k12(2))*p1(:,:,2)
     &                  + (a213(2)+a2k13(2))*t2r0(:,:,2)
     &                  + (a214(2)+a2k14(2))*t3r0(:,:,2)
         xdr0(:,:,2) = (a210(1)+a2k11a(1))*field(:,:,2)
     &                  + (a21n1(1)+a2k12a(1))*te(:,:,2)
     &                  + a2k10a(1)*udirp - a2k11a(1)*r0(:,:,2)
     &                  - a2k12a(1)*p1(:,:,2)
     &                  + (a211(1)+a2k11(1))*r0(:,:,1)
     &                  + (a212(1)+a2k12(1))*p1(:,:,1)
     &                  + (a213(1)+a2k13(1))*t2r0(:,:,1)
     &                  + (a214(1)+a2k14(1))*t3r0(:,:,1)
c
c     xde = mu + mu0 + alpha.(-Tu.x)
c
         call tcg_ufield (xdr0(:,:,1),xdr0(:,:,2),xde(:,:,1),xde(:,:,2))
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind + udir)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp + udirp)
         ubp(:,:,3) = 0.5d0 * xdr0(:,:,2)
         ubd(:,:,3) = 0.5d0 * xdr0(:,:,1)
         uad(:,:,1) = r0(:,:,1)
         uad(:,:,2) = p1(:,:,1)
         uad(:,:,3) = udir 
         uap(:,:,1) = r0(:,:,2)
         uap(:,:,2) = p1(:,:,2)
         uap(:,:,3) = udirp
         goto 10
      end if
c
c     store induced dipoles from elements of the xde arrays
c
   10 continue
      uind = xde(:,:,1)
      uinp = xde(:,:,2)
c
c     perform deallocation of some local arrays
c
      deallocate (field)
      deallocate (xde)
      deallocate (xdr0)
      deallocate (r0)
      deallocate (p1)
      deallocate (r1)
      deallocate (t2r0)
      deallocate (t3r0)
      deallocate (te)
      return
      end
c
c
c     #################################################################
c     ##                                                             ##
c     ##  subroutine induce1c  -- TCG zero guess and preconditioner  ##
c     ##                                                             ##
c     #################################################################
c
c
c     "induce1c" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with initial
c     guess mu0 = 0 and diagonal preconditioner = true
c
c
      subroutine induce1c
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j
      integer order
      real*8 sp0,spp1
      real*8 sp1,spp2
      real*8 n0(2),n1(2)
      real*8 np1(2),nrsd1(2)
      real*8 b1(2),b2(2)
      real*8 t1(2),t2(2)
      real*8 t3(2),t4(2)
      real*8 t8(2),t9(2)
      real*8 t10(2)
      real*8 beta1(2),gamma1(2)
      real*8 a110(2),a111(2)
      real*8 a112(2),a121(2)
      real*8 a1k10a(2),a1k11a(2)
      real*8 a1k11(2),a1k12(2)
      real*8 a1k20a(2),a1k21(2)
      real*8 a210(2),a21n1(2)
      real*8 a211(2),a212(2)
      real*8 a213(2),a214(2)
      real*8 a220(2),a221(2)
      real*8 a222(2),a223(2)
      real*8 a231(2),a232(2)
      real*8 a241(2),a2k10a(2)
      real*8 a2k11a(2),a2k12a(2)
      real*8 a2k11(2),a2k12(2)
      real*8 a2k13(2),a2k14(2)
      real*8 a2k20a(2),a2k21a(2)
      real*8 a2k21(2),a2k22(2)
      real*8 a2k23(2),a2k30a(2)
      real*8 a2k31(2),a2k32(2)
      real*8 a2k41(2)
      real*8 a2kwt2(2),a2kwg1(2)
      real*8, allocatable :: r0(:,:,:)
      real*8, allocatable :: xde(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: r1(:,:,:)
      real*8, allocatable :: t2m0(:,:,:)
      real*8, allocatable :: t3m0(:,:,:)
      logical converge
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based upon the tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation of some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
c
c     perform dynamic allocation for some local arrays
c
      allocate (r0(3,n,2))
      allocate (xde(3,n,2))
      allocate (p1(3,n,2))
      allocate (r1(3,n,2))
      allocate (t2m0(3,n,2))
      allocate (t3m0(3,n,2))
c
c     get the electrostaic field due to permanent multipoles
c     because mu0 = 0, r0 = field - T.mu0 = field
c
      if (use_ewald) then
         call dfield0c (r0(:,:,1),r0(:,:,2))
      else if (use_mlist) then
         call dfield0b (r0(:,:,1),r0(:,:,2))
      else
         call dfield0a (r0(:,:,1),r0(:,:,2))
      end if
c
c     udir = alpha.E = alpha.r0
c     m0 = M.r0 = alpha.E = udir
c
      call tcg_alpha22 (r0(:,:,1),r0(:,:,2),udir,udirp)
c
c     compute tcg1 intermediates
c     n0 = r0.M.r0 = E.alpha.E = r0.udir
c     p1 = T.m0 = tae
c     t1 = m0.T.m0 = p1.m0
c
      call tcg_dotprod (n0(1),3*npole,r0(:,:,1),udir)
      call tcg_dotprod (n0(2),3*npole,r0(:,:,2),udirp)
      call tcg_t0 (udir,udirp,p1(:,:,1),p1(:,:,2))
      call tcg_dotprod (t1(1),3*npole,p1(:,:,1),udir)
      call tcg_dotprod (t1(2),3*npole,p1(:,:,2),udirp)
      t4(1) = n0(1) / t1(1)
      t4(2) = n0(2) / t1(2)
c
c     mu1 = mu0 + gamma0 * p0 (or m0)
c
      uind = uind + t4(1) * udir
      uinp = uinp + t4(2) * udirp
c
c     r1 = r0 - gamma0 * T.p0 (or T.m0)
c
      r1(:,:,1) = r0(:,:,1) - t4(1)*p1(:,:,1)
      r1(:,:,2) = r0(:,:,2) - t4(2)*p1(:,:,2)
c
c     check convergence, stop at tcg1 level if n1 is small enough
c
      call tcg_dotprod (nrsd1(1),3*npole,r1(:,:,1),r1(:,:,1))
      call tcg_dotprod (nrsd1(2),3*npole,r1(:,:,2),r1(:,:,2))
      call tcg_converge (converge,nrsd1(1),nrsd1(2))
      if (converge) then
         order = 1
         call tcg_resource (order)
      end if
c
c     n1 = r1.M.r1
c
      call tcg_alphaquad (n1(1),r1(:,:,1),r1(:,:,1))
      call tcg_alphaquad (n1(2),r1(:,:,2),r1(:,:,2))
c
c     cross terms
c     sp0 = r0.M.E = r0.udir
c     spp1 = m0.T.alpha.E = sp1
c
      call tcg_dotprod (sp0,3*npole,r0(:,:,1),udirp)
      call tcg_dotprod (spp1,3*npole,p1(:,:,1),udirp)
c
c     tcg1 force and energy
c
      if (order .eq. 1) then
c
c     compute a(1) coefficients: a1...
c     and a(1k) coefficients: a1k...
c
         do i = 1, 2
            a110(i) = t4(i)
            a111(i) = 2.0d0 * sp0 / t1(i)
            a112(i) = -t4(i) * a111(i)
            a121(i) = 0.5d0 * a112(i)
            a1k10a(i) = tcgpeek
            a1k11a(i) = -tcgpeek * t4(i)
            a1k11(i) = -2.0d0 * spp1 * tcgpeek / t1(i)
            a1k12(i) = -t4(i) * a1k11(i)
            a1k20a(i) = a1k11a(i)
            a1k21(i) = 0.5d0 * a1k12(i)
         end do
c
c     mu1(peek) = mu1 + omega * alpha.r1
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = -0.5d0*((a121(1)+a1k21(1))*udir
     &                           + a1k20a(1)*udirp)
         ubd(:,:,1) = -0.5d0*((a121(2)+a1k21(2))*udirp
     &                           + a1k20a(2)*udir)
         xde(:,:,1) = (a110(2)+a1k10a(2))*r0(:,:,1)
     &                 + (a111(2)+a1k11(2))*r0(:,:,2)
     &                 + (a112(2)+a1k12(2))*p1(:,:,2)
     &                 + a1k11a(2)*p1(:,:,1)
         xde(:,:,2) = (a110(1)+a1k10a(1))*r0(:,:,2)
     &                 + (a111(1)+a1k11(1))*r0(:,:,1)
     &                 + (a112(1)+a1k12(1))*p1(:,:,1)
     &                 + a1k11a(1)*p1(:,:,2)
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp)
         uad(:,:,1) = udir
         uap(:,:,1) = udirp
         goto 10
      end if
c
c     compute tcg2 intermediates, use "xde" as temporary storage
c     t2m0 = T.M.T.M.r0 = T.M.p1
c     t3m0 = T.(M.T)^2.M.r0 = T.M.t2m0
c     t9 = r0.M.T.M.T.M.T.M.r0 = t2m0.M.p1
c
      call tcg_alpha22 (p1(:,:,1),p1(:,:,2),xde(:,:,1),xde(:,:,2))
      call tcg_t0 (xde(:,:,1),xde(:,:,2),t2m0(:,:,1),t2m0(:,:,2))
      call tcg_alpha22 (t2m0(:,:,1),t2m0(:,:,2),xde(:,:,1),xde(:,:,2))
      call tcg_t0 (xde(:,:,1),xde(:,:,2),t3m0(:,:,1),t3m0(:,:,2))
      call tcg_alphaquad (t9(1),t2m0(:,:,1),p1(:,:,1))
      call tcg_alphaquad (t9(2),t2m0(:,:,2),p1(:,:,2))
c
c     beta1 = r1.r1/r0.r0 = n1/n0
c     t2 = 1 + beta1
c
      beta1(1) = n1(1) / n0(1)
      beta1(2) = n1(2) / n0(2)
      t2(1) = 1.0d0 + beta1(1)
      t2(2) = 1.0d0 + beta1(2)
c
c     np1 = p1.M.p1
c     t8 = t2*np1 - t4*t9
c     t10 = t1^2 - n0.|p1|^2
c     t3  = t1*t8
c     gamma1 = t10/t3
c
      call tcg_alphaquad (np1(1),p1(:,:,1),p1(:,:,1))
      call tcg_alphaquad (np1(2),p1(:,:,2),p1(:,:,2))
      t8(1) = t2(1)*np1(1) - t4(1)*t9(1)
      t8(2) = t2(2)*np1(2) - t4(2)*t9(2)
      t10(1) = t1(1)**2 - n0(1)*np1(1)
      t10(2) = t1(2)**2 - n0(2)*np1(2)
      t3(1) = t1(1)*t8(1)
      t3(2) = t1(2)*t8(2)
      gamma1(1) = t10(1) / t3(1)
      gamma1(2) = t10(2) / t3(2)
c
c     mu2 = mu1 + gamma1*p1 = mu1 + gamma1*(M.r1 + beta1*p0)
c         = mu1 + gamma1*(t2*p0 - t4*M.T.p0)
c         = mu1 + gamma1*(t2*M.r0 - t4*M.T.M.r0)
c         = mu1 + gamma1*M.(t2*r0 - t4*p1)
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = uind(j,i) + (t2(1)*r0(j,i,1) - t4(1)*p1(j,i,1))
     &                     * gamma1(1) * polarity(i)
            uinp(j,i) = uinp(j,i) + (t2(2)*r0(j,i,2) - t4(2)*p1(j,i,2))
     &                     * gamma1(2) * polarity(i)
         end do
      end do
c
c     r2 = r1 - gamma1 * T.p1 = r1 - gamma1 * p2
c        = r1 - gamma1 * (t2*T.M.r0 - t4*T.M.T.M.r0)
c        = r1 - gamma1 * (t2*p1 - t4*t2m0)
c     reuse r1 as r2
c
      r1(:,:,1) = r1(:,:,1)
     &               - gamma1(1)*(t2(1)*p1(:,:,1)-t4(1)*t2m0(:,:,1))
      r1(:,:,2) = r1(:,:,2)
     &               - gamma1(2)*(t2(2)*p1(:,:,2)-t4(2)*t2m0(:,:,2))
c
c     cross terms
c     sp1 = p1.M.E = p1.udir = spp1
c     b1 = sp0 - gamma1*sp1
c     b2 = sp0*t2 - t4*sp1
c     spp2 = r0.M.T.M.T.alpha.E = p1.M.p1
c
      sp1 = spp1
      b1(1) = sp0 - gamma1(1)*sp1
      b1(2) = sp0 - gamma1(2)*sp1
      b2(1) = sp0*t2(1) - t4(1)*sp1
      b2(2) = sp0*t2(2) - t4(2)*sp1
      call tcg_alphaquad (spp2,p1(:,:,1),p1(:,:,2))
c
c     tcg2 force and energy
c
      if (order .eq. 2) then
c
c     compute a(2) coefficients: a2...
c     and a(2k) coefficients: a2k...
c
         do i = 1, 2
            a232(i) = t1(i)*t4(i)*gamma1(i)*b2(i)/t3(i)
            a241(i) = a232(i)
            a231(i) = -n0(i)*b2(i)/t3(i)
     &                -2.0d0*t1(i)*t2(i)*gamma1(i)*b2(i)/t3(i)
     &                +t4(i)*gamma1(i)*sp0/t1(i)
            a223(i) = a232(i)
            a222(i) = a231(i)
            a221(i) = -t4(i)*b1(i)/t1(i) +2.0d0*t1(i)*b2(i)/t3(i)
     &                -t4(i)*t9(i)*gamma1(i)*b2(i)/t3(i)
     &                +2.0d0*t2(i)*np1(i)*gamma1(i)*b2(i)/t3(i)
     &                -t8(i)*gamma1(i)*b2(i)/t3(i)
     &                -2.0d0*t4(i)*np1(i)*sp0*gamma1(i)/(t1(i)**2)
            a220(i) = -gamma1(i)*t4(i)
            a214(i) = 2.0d0*a232(i)
            a213(i) = 2.0d0*a231(i)
            a212(i) = 2.0d0*a221(i)
            a211(i) = 2.0d0*(b1(i)/t1(i) -np1(i)*b2(i)/t3(i)
     &                   -(np1(i)**2)*gamma1(i)*b2(i)/t3(i)/t1(i)
     &                   +t9(i)*gamma1(i)*b2(i)/t3(i)
     &                   +np1(i)*sp0*gamma1(i)/(t1(i)**2))
            a21n1(i) = a220(i)
            a210(i) = t4(i) + gamma1(i)*t2(i)
            a2kwt2(i) = tcgpeek*(t2(i)*spp1-t4(i)*spp2)
            a2kwg1(i) = tcgpeek*(spp1-gamma1(i)*spp2)
            a2k41(i) = -a2kwt2(i)*t1(i)*t4(i)*gamma1(i)/t3(i)
            a2k32(i) = a2k41(i)
            a2k31(i) = -tcgpeek*t4(i)*gamma1(i)*spp1/t1(i)
     &                 +a2kwt2(i)*(n0(i)/t3(i)
     &                    +2.0d0*t1(i)*t2(i)*gamma1(i)/t3(i))
            a2k30a(i) = tcgpeek*gamma1(i)*t4(i)
            a2k23(i) = a2k41(i)
            a2k22(i) = a2k31(i)
            a2k21(i) = 2.0d0*t4(i)*np1(i)/(t1(i)**2)*
     &                    tcgpeek*gamma1(i)*spp1
     &                 +a2kwt2(i)*(-2.0d0*t1(i)+
     &                    (t4(i)*t9(i)-2.0d0*np1(i)*t2(i)+t8(i))*
     &                    gamma1(i))/t3(i)
     &                 +t4(i)*a2kwg1(i)/t1(i)
            a2k21a(i) = a2k30a(i)
            a2k20a(i) = -tcgpeek*(gamma1(i)*t2(i)+t4(i))
            a2k14(i) = 2.0d0*a2k41(i)
            a2k13(i) = 2.0d0*a2k22(i)
            a2k12(i) = 2.0d0*a2k21(i)
            a2k11(i) = -np1(i)/(t1(i)**2)*tcgpeek*gamma1(i)*spp1
     &                 +a2kwt2(i)*(np1(i)
     &                    +(np1(i)**2)*gamma1(i)/t1(i)
     &                    -t9(i)*gamma1(i))/t3(i)
     &                 -a2kwg1(i)/t1(i)
            a2k11(i) = 2.0d0*a2k11(i)
            a2k12a(i) = a2k30a(i)
            a2k11a(i) = a2k20a(i)
            a2k10a(i) = tcgpeek
         end do
c
c     mu2(peek) = mu2 + omega * alpha.r2
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = -0.5d0*((a220(1)+a2k20a(1))*r0(:,:,2)
     &                 + (a221(1)+a2k21(1))*r0(:,:,1)
     &                 + (a222(1)+a231(1)+a2k22(1)+a2k31(1))*p1(:,:,1)
     &                 + a2k21a(1)*p1(:,:,2)
     &                 + (a223(1)+a241(1)+a2k23(1)
     &                       +a2k41(1))*t2m0(:,:,1))
         ubd(:,:,1) = -0.5d0*((a220(2)+a2k20a(2))*r0(:,:,1)
     &                 + (a221(2)+a2k21(2))*r0(:,:,2)
     &                 + (a222(2)+a231(2)+a2k22(2)+a2k31(2))*p1(:,:,2)
     &                 + a2k21a(2)*p1(:,:,1)
     &                 + (a223(2)+a241(2)+a2k23(2)
     &                       +a2k41(2))*t2m0(:,:,2))
         ubp(:,:,2) = -0.5d0*((a232(1)+a2k32(1))*p1(:,:,1)
     &                              + a2k30a(1)*r0(:,:,2))
         ubd(:,:,2) = -0.5d0*((a232(2)+a2k32(2))*p1(:,:,2)
     &                              + a2k30a(2)*r0(:,:,1))
         xde(:,:,1) = (a210(2)+a2k10a(2))*r0(:,:,1)
     &                 + (a211(2)+a2k11(2))*r0(:,:,2)
     &                 + (a21n1(2)+a2k11a(2))*p1(:,:,1)
     &                 + (a212(2)+a2k12(2))*p1(:,:,2)
     &                 + a2k12a(2)*t2m0(:,:,1)
     &                 + (a213(2)+a2k13(2))*t2m0(:,:,2)
     &                 + (a214(2)+a2k14(2))*t3m0(:,:,2)
         xde(:,:,2) = (a210(1)+a2k10a(1))*r0(:,:,2)
     &                 + (a211(1)+a2k11(1))*r0(:,:,1)
     &                 + (a21n1(1)+a2k11a(1))*p1(:,:,2)
     &                 + (a212(1)+a2k12(1))*p1(:,:,1)
     &                 + a2k12a(1)*t2m0(:,:,2)
     &                 + (a213(1)+a2k13(1))*t2m0(:,:,1)
     &                 + (a214(1)+a2k14(1))*t3m0(:,:,1)
         call tcg_alpha12 (xde(:,:,1),xde(:,:,2))
         xde(:,:,1) = 0.5d0 * (xde(:,:,1) + uind)
         xde(:,:,2) = 0.5d0 * (xde(:,:,2) + uinp)
         call tcg_alpha12 (ubp(:,:,1),ubd(:,:,1))
         call tcg_alpha12 (ubp(:,:,2),ubd(:,:,2))
         uad(:,:,1) = udir
         uap(:,:,1) = udirp
         call tcg_alpha22 (p1(:,:,1),p1(:,:,2),uad(:,:,2),uap(:,:,2))
         goto 10
      end if
c
c     store induced dipoles from elements of the xde arrays
c
   10 continue
      uind = xde(:,:,1)
      uinp = xde(:,:,2)
c
c     perform deallocation of some local arrays
c
      deallocate (r0)
      deallocate (xde)
      deallocate (p1)
      deallocate (r1)
      deallocate (t2m0)
      deallocate (t3m0)
      return
      end
c
c
c     ###################################################################
c     ##                                                               ##
c     ##  subroutine induce1cx  --  TCG zero guess and preconditioner  ##
c     ##                                                               ##
c     ###################################################################
c
c
c     "induce1cx" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with dp
c     cross terms = true, initial guess mu0 = 0 and diagonal
c     preconditioner = true
c
c
      subroutine induce1cx
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j,order
      real*8 n0,np0,g0
      real*8 n1,beta1,np1,g1
      real*8 n2,beta2,np2,g2
      real*8 n3,beta3
      real*8 a100,a101,a102,a103,b111
      real*8, allocatable :: rsd(:,:,:)
      real*8, allocatable :: r0(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: p2(:,:,:)
      real*8, allocatable :: p3(:,:,:)
      real*8, allocatable :: tp(:,:,:)
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based on tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation for some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
      uad = 0.0d0
      uap = 0.0d0
      ubd = 0.0d0
      ubp = 0.0d0
c
c     perform dynamic allocation for some local arrays
c
      allocate (rsd(3,n,2))
      allocate (r0(3,n,2))
      allocate (p1(3,n,2))
      allocate (p2(3,n,2))
      allocate (p3(3,n,2))
      allocate (tp(3,n,2))
c
c     get the electrostaic field due to permanent multipoles
c     because mu0 = 0, r0 = field - T.mu0 = field
c
      if (use_ewald) then
         call dfield0c (r0(:,:,1),r0(:,:,2))
      else if (use_mlist) then
         call dfield0b (r0(:,:,1),r0(:,:,2))
      else
         call dfield0a (r0(:,:,1),r0(:,:,2))
      end if
c
c     udir = alpha.E = alpha.r0
c
      call tcg_alpha22 (r0(:,:,1),r0(:,:,2),udir,udirp)
c
c     compute tcg1 intermediates
c     p0 = alpha.r0 = udir
c     n0 = r0.a.r0
c     np0 = p0.T.p0
c
      call tcg_alpha22 (r0(:,:,1),r0(:,:,2),udir,udirp)
      call tcg_alphaquad (n0,r0(:,:,1),r0(:,:,2))
      call tcg_t0 (udir,udirp,tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np0,3*npole,tp(:,:,1),udirp)
      g0 = n0 / np0
c
c     r1 = r0 - gamma0 * T.p0
c     n1 = r1.a.r1
c     p1 <- r1, p0
c
      rsd = r0 - g0 * tp
      call tcg_alphaquad (n1,rsd(:,:,1),rsd(:,:,2))
      beta1 = n1 / n0
      p1(:,:,1) = udir
      p1(:,:,2) = udirp
      call tcg_update_pvec (p1(:,:,1),rsd(:,:,1),beta1)
      call tcg_update_pvec (p1(:,:,2),rsd(:,:,2),beta1)
c
c     ua(1) = mu1 = g0 * p0
c     ub(1) <- p0
c     xde <- p0, p1
c
      uad(:,:,1) = g0*udir
      uap(:,:,1) = g0*udirp
      ubd(:,:,1) = ubd(:,:,1) + 0.5d0*g0*udir
      ubp(:,:,1) = ubp(:,:,1) + 0.5d0*g0*udirp
      uind = uind + g0*(1.0d0-beta1)*udir + g0*p1(:,:,1)
      uinp = uinp + g0*(1.0d0-beta1)*udirp + g0*p1(:,:,2)
c
c     tcg1 force and energy
c
      if (order .eq. 1) then
         goto 10
      end if
c
c     np1 = p1.T.p1
c     g1 = n1 / np1
c     r2 = r1 - g1 * T.p1
c     n2 = r2.a.r2
c     beta2 = n2 / n1
c
      call tcg_t0 (p1(:,:,1),p1(:,:,2),tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np1,3*npole,tp(:,:,1),p1(:,:,2))
      g1 = n1 / np1
      rsd = rsd - g1 * tp
      call tcg_alphaquad (n2,rsd(:,:,1),rsd(:,:,2))
      beta2 = n2 / n1
c
c     p2 <- r2, p1
c     np2 = p2.T.p2
c     g2 = n2 / np2
c
      p2 = p1
      call tcg_update_pvec (p2(:,:,1),rsd(:,:,1),beta2)
      call tcg_update_pvec (p2(:,:,2),rsd(:,:,2),beta2)
      call tcg_t0 (p2(:,:,1),p2(:,:,2),tp(:,:,1),tp(:,:,2))
      call tcg_dotprod (np2,3*npole,tp(:,:,1),p2(:,:,2))
      g2 = n2 / np2
c
c     r3 = r2 - g2 * T.p2
c     n3 = r3.a.r3
c     beta3 = n3 / n2
c
      rsd = rsd - g2 * tp
      call tcg_alphaquad (n3,rsd(:,:,1),rsd(:,:,2))
      beta3 = n3 / n2
c
c     p3 <- r3, p2
c
      p3 = p2
      call tcg_update_pvec (p3(:,:,1),rsd(:,:,1),beta3)
      call tcg_update_pvec (p3(:,:,2),rsd(:,:,2),beta3)
c
c     ua(2) = mu2 = g1 * p1
c     ub(1) <- p1, p2
c     ub(2) <- p1
c     xde <- p0, p1
c
      b111 = (1.0d0-beta2) * g1
      a103 = g0*g1/g2
      a102 = (1.0d0-beta2)*g0 + (1.0d0+beta1)*g1 - (1.0d0+beta3)*a103
      a101 = (beta2**2-1.0d0)*g0 + (1.0d0-beta2-beta1*beta2)*g1
     &          + beta2*a103
      a100 = (1.0d0-beta2)*g0*beta1
      uad(:,:,2) = g1*p1(:,:,1)
      uap(:,:,2) = g1*p1(:,:,2)
      ubd(:,:,1) = ubd(:,:,1) + b111*p1(:,:,1) + g1*p2(:,:,1)
      ubp(:,:,1) = ubp(:,:,1) + b111*p1(:,:,2) + g1*p2(:,:,2)
      ubd(:,:,2) = ubd(:,:,2) + 0.5d0*g1*p1(:,:,1)
      ubp(:,:,2) = ubp(:,:,2) + 0.5d0*g1*p1(:,:,2)
      uind = uind + a103*p3(:,:,1) + a102*p2(:,:,1) + a101*p1(:,:,1)
     &          + a100*udir
      uinp = uinp + a103*p3(:,:,2) + a102*p2(:,:,2) + a101*p1(:,:,2)
     &          + a100*udirp
c
c     tcg2 force and energy
c
      if (order .eq. 2) then
         goto 10
      end if
c
c     perform deallocation for some local arrays
c
   10 continue
      deallocate (rsd)
      deallocate (r0)
      deallocate (p1)
      deallocate (p2)
      deallocate (p3)
      deallocate (tp)
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine induce1d  -- TCG zero guess and no precondition  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "induce1d" computes the induced dipoles and intermediates used
c     in polarization force calculation for the TCG method with initial
c     guess mu0 = 0 and diagonal preconditioner = false
c
c
      subroutine induce1d
      use atoms
      use limits
      use mpole
      use polar
      use poltcg
      use potent
      implicit none
      integer i,j
      integer order
      real*8 sp0,spp1(2)
      real*8 sp1,spp2(2)
      real*8 n0(2),n1(2)
      real*8 np1(2)
      real*8 b1(2),b2(2)
      real*8 t1(2),t2(2)
      real*8 t3(2),t4(2)
      real*8 t8(2),t9(2)
      real*8 t10(2)
      real*8 beta1(2),gamma1(2)
      real*8 a110(2),a111(2)
      real*8 a112(2),a121(2)
      real*8 a1k10a(2),a1k11a(2)
      real*8 a1k11(2),a1k12(2)
      real*8 a1k20a(2),a1k21(2)
      real*8 a210(2),a21n1(2)
      real*8 a211(2),a212(2)
      real*8 a213(2),a214(2)
      real*8 a220(2),a221(2)
      real*8 a222(2),a223(2)
      real*8 a231(2),a232(2)
      real*8 a241(2),a2k10a(2)
      real*8 a2k11a(2),a2k12a(2)
      real*8 a2k11(2),a2k12(2)
      real*8 a2k13(2),a2k14(2)
      real*8 a2k20a(2),a2k21a(2)
      real*8 a2k21(2),a2k22(2)
      real*8 a2k23(2),a2k30a(2)
      real*8 a2k31(2),a2k32(2)
      real*8 a2k41(2)
      real*8 a2kwt2(2),a2kwg1(2)
      real*8, allocatable :: r0(:,:,:)
      real*8, allocatable :: xde(:,:,:)
      real*8, allocatable :: p1(:,:,:)
      real*8, allocatable :: r1(:,:,:)
      real*8, allocatable :: tae(:,:,:)
      real*8, allocatable :: t2r0(:,:,:)
      real*8, allocatable :: t3r0(:,:,:)
      real*8, allocatable :: t2ae(:,:,:)
      logical converge
c
c
c     zero out the induced dipoles at each site
c
      do i = 1, npole
         do j = 1, 3
            uind(j,i) = 0.0d0
            uinp(j,i) = 0.0d0
         end do
      end do
      if (.not. use_polar)  return
c
c     set up nab based upon the tcgorder value
c
      order = tcgorder
      call tcg_resource (order)
c
c     perform dynamic allocation of some global arrays
c
      if (.not. allocated(uad))  allocate (uad(3,n,tcgnab))
      if (.not. allocated(uap))  allocate (uap(3,n,tcgnab))
      if (.not. allocated(ubd))  allocate (ubd(3,n,tcgnab))
      if (.not. allocated(ubp))  allocate (ubp(3,n,tcgnab))
c
c     perform dynamic allocation for some local arrays
c
      allocate (r0(3,n,2))
      allocate (xde(3,n,2))
      allocate (p1(3,n,2))
      allocate (r1(3,n,2))
      allocate (tae(3,n,2))
      allocate (t2r0(3,n,2))
      allocate (t3r0(3,n,2))
      allocate (t2ae(3,n,2))
c
c     get the electrostaic field due to permanent multipoles
c     because mu0 = 0, r0 = field - T.mu0 = field
c
      if (use_ewald) then
         call dfield0c (r0(:,:,1),r0(:,:,2))
      else if (use_mlist) then
         call dfield0b (r0(:,:,1),r0(:,:,2))
      else
         call dfield0a (r0(:,:,1),r0(:,:,2))
      end if
c
c     udir = alpha.E = alpha.r0
c
      call tcg_alpha22 (r0(:,:,1),r0(:,:,2),udir,udirp)
c
c     compute tcg1 intermediates
c     n0 = r0.r0
c     P1 = T.r0 = T.E
c     t1 = r0.T.r0 = E.T.E
c     (t4 or gamma0) = r0.r0/r0.T.r0
c
      call tcg_dotprod (n0(1),3*npole,r0(:,:,1),r0(:,:,1))
      call tcg_dotprod (n0(2),3*npole,r0(:,:,2),r0(:,:,2))
      call tcg_t0 (r0(:,:,1),r0(:,:,2),p1(:,:,1),p1(:,:,2))
      call tcg_dotprod (t1(1),3*npole,r0(:,:,1),p1(:,:,1))
      call tcg_dotprod (t1(2),3*npole,r0(:,:,2),p1(:,:,2))
      t4(1) = n0(1) / t1(1)
      t4(2) = n0(2) / t1(2)
c
c     mu1 = mu0 + gamma0 * p0 (or r0)
c
      uind = uind + t4(1) * r0(:,:,1)
      uinp = uinp + t4(2) * r0(:,:,2)
c
c     tae = T.alpha.E = T.udir
c
      call tcg_t0 (udir,udirp,tae(:,:,1),tae(:,:,2))
c
c     r1 = r0 - gamma0 * T.p0 (or T.r0, or p1)
c
      r1(:,:,1) = r0(:,:,1) - t4(1)*p1(:,:,1)
      r1(:,:,2) = r0(:,:,2) - t4(2)*p1(:,:,2)
c
c     n1 = r1.r1
c     check convergence, stop at tcg1 level if n1 is small enough
c
      call tcg_dotprod (n1(1),3*npole,r1(:,:,1),r1(:,:,1))
      call tcg_dotprod (n1(2),3*npole,r1(:,:,2),r1(:,:,2))
      call tcg_converge (converge,n1(1),n1(2))
      if (converge) then
         order = 1
         call tcg_resource (order)
      end if
c
c     cross terms
c     sp0 = r0.E
c     spp1 = r0.T.alpha.E = r0.T.mu0
c
      call tcg_dotprod (sp0,3*npole,r0(:,:,1),r0(:,:,2))
      call tcg_dotprod (spp1(1),3*npole,p1(:,:,1),udirp)
      call tcg_dotprod (spp1(2),3*npole,p1(:,:,2),udir)
c
c     tcg1 force and energy
c
      if (order .eq. 1) then
c
c     compute a(1) coefficients: a1...
c     and a(1k) coefficients: a1k...
c
         do i = 1, 2
            a110(i) = t4(i)
            a111(i) = 2.0d0 * sp0 / t1(i)
            a112(i) = -t4(i) * a111(i)
            a121(i) = 0.5d0 * a112(i)
            a1k10a(i) = tcgpeek
            a1k11a(i) = -tcgpeek * t4(i)
            a1k11(i) = -2.0d0 * spp1(i) * tcgpeek / t1(i)
            a1k12(i) = -t4(i) * a1k11(i)
            a1k20a(i) = a1k11a(i)
            a1k21(i) = 0.5d0 * a1k12(i)
         end do
c
c     mu1(peek) = mu1 + omega * alpha.r1
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = -0.5d0 * ((a121(1)+a1k21(1))*r0(:,:,1)
     &                             + a1k20a(1)*udirp)
         ubd(:,:,1) = -0.5d0 * ((a121(2)+a1k21(2))*r0(:,:,2)
     &                             + a1k20a(2)*udir)
         xde(:,:,1) = 0.5d0 * (uind + a110(2)*r0(:,:,1)
     &                   + (a111(2)+a1k11(2))*r0(:,:,2)
     &                   + (a112(2)+a1k12(2))*p1(:,:,2)
     &                   + a1k10a(2)*udir + a1k11a(2)*tae(:,:,1))
         xde(:,:,2) = 0.5d0 * (uinp + a110(1)*r0(:,:,2)
     &                   + (a111(1)+a1k11(1))*r0(:,:,1)
     &                   + (a112(1)+a1k12(1))*p1(:,:,1)
     &                   + a1k10a(1)*udirp + a1k11a(1)*tae(:,:,2))
         uad(:,:,1) = r0(:,:,1)
         uap(:,:,1) = r0(:,:,2)
         goto 10
      end if
c
c     compute tcg2 intermediates
c     t2r0 = T^2.r0 = T.p1
c     t3r0 = T^3.r0
c     te = T.E = T.r0 = p1
c     t9 = r0.T^3.r0 = r0.T^2.T.r0
c
      call tcg_t0 (p1(:,:,1),p1(:,:,2),t2r0(:,:,1),t2r0(:,:,2))
      call tcg_t0 (t2r0(:,:,1),t2r0(:,:,2),t3r0(:,:,1),t3r0(:,:,2))
      call tcg_dotprod (t9(1),3*npole,t2r0(:,:,1),p1(:,:,1))
      call tcg_dotprod (t9(2),3*npole,t2r0(:,:,2),p1(:,:,2))
c
c     beta1 = r1.r1/r0.r0 = n1/n0
c     t2 = 1 + beta1
c
      beta1(1) = n1(1) / n0(1)
      beta1(2) = n1(2) / n0(2)
      t2(1) = 1.0d0 + beta1(1)
      t2(2) = 1.0d0 + beta1(2)
c
c     np1 = p1.p1
c     t8 = t5 = p1.T.p1 = p1.p2 = t2*np1 - t4*t9
c     t10 = t1^2 - n0.|p1|^2
c     t3 = t1*p1.p2 = t1*t8
c     gamma1 = t10/t3
c
      call tcg_dotprod (np1(1),3*npole,p1(:,:,1),p1(:,:,1))
      call tcg_dotprod (np1(2),3*npole,p1(:,:,2),p1(:,:,2))
      t8(1) = t2(1)*np1(1) - t4(1)*t9(1)
      t8(2) = t2(2)*np1(2) - t4(2)*t9(2)
      t10(1) = t1(1)**2 - n0(1)*np1(1)
      t10(2) = t1(2)**2 - n0(2)*np1(2)
      t3(1) = t1(1)*t8(1)
      t3(2) = t1(2)*t8(2)
      gamma1(1) = t10(1) / t3(1)
      gamma1(2) = t10(2) / t3(2)
c
c     mu2 = mu1 + gamma1*p1 = mu1 + gamma1*(r1 + beta1*p0)
c         = mu1 + gamma1*(r1 + beta1*r0)
c
      uind = uind + gamma1(1)*(r1(:,:,1) + beta1(1)*r0(:,:,1))
      uinp = uinp + gamma1(2)*(r1(:,:,2) + beta1(2)*r0(:,:,2))
c
c     t2ae = T^2.alpha.E = T.tae
c
      call tcg_t0 (tae(:,:,1),tae(:,:,2),t2ae(:,:,1),t2ae(:,:,2))
c
c     r2 = r1 - gamma1 * T.p1 = r1 - gamma1 * p2
c        = r1 - gamma1 * (t2*p1 - t4*t2r0)
c     reuse r1 as r2
c
      r1(:,:,1) = r1(:,:,1)
     &               - gamma1(1)*(t2(1)*p1(:,:,1)-t4(1)*t2r0(:,:,1))
      r1(:,:,2) = r1(:,:,2)
     &               - gamma1(2)*(t2(2)*p1(:,:,2)-t4(2)*t2r0(:,:,2))
c
c     cross terms
c     sp1 = r0.T.E = p1.E
c     b1 = sp0 - gamma1*sp1
c     b2 = sp0*t2 - t4*sp1
c     spp2 = r0.T.T.alpha.E
c
      call tcg_dotprod (sp1,3*npole,p1(:,:,1),r0(:,:,2))
      b1(1) = sp0 - gamma1(1)*sp1
      b1(2) = sp0 - gamma1(2)*sp1
      b2(1) = sp0*t2(1) - t4(1)*sp1
      b2(2) = sp0*t2(2) - t4(2)*sp1
      call tcg_dotprod (spp2(1),3*npole,t2r0(:,:,1),udirp)
      call tcg_dotprod (spp2(2),3*npole,t2r0(:,:,2),udir)
c
c     tcg2 force and energy
c
      if (order .eq. 2) then
c
c     compute a(2) coefficients: a2...
c     and a(2k) coefficients: a2k...
c
         do i = 1, 2
            a232(i) = t1(i)*t4(i)*gamma1(i)*b2(i)/t3(i)
            a241(i) = a232(i)
            a231(i) = -n0(i)*b2(i)/t3(i)
     &                -2.0d0*t1(i)*t2(i)*gamma1(i)*b2(i)/t3(i)
     &                +t4(i)*gamma1(i)*sp0/t1(i)
            a223(i) = a232(i)
            a222(i) = a231(i)
            a221(i) = -t4(i)*b1(i)/t1(i) +2.0d0*t1(i)*b2(i)/t3(i)
     &                -t4(i)*t9(i)*gamma1(i)*b2(i)/t3(i)
     &                +2.0d0*t2(i)*np1(i)*gamma1(i)*b2(i)/t3(i)
     &                -t8(i)*gamma1(i)*b2(i)/t3(i)
     &                -2.0d0*t4(i)*np1(i)*sp0*gamma1(i)/(t1(i)**2)
            a220(i) = -gamma1(i)*t4(i)
            a214(i) = 2.0d0*a232(i)
            a213(i) = 2.0d0*a231(i)
            a212(i) = 2.0d0*a221(i)
            a211(i) = 2.0d0*(b1(i)/t1(i) -np1(i)*b2(i)/t3(i)
     &                   -(np1(i)**2)*gamma1(i)*b2(i)/t3(i)/t1(i)
     &                   +t9(i)*gamma1(i)*b2(i)/t3(i)
     &                   +np1(i)*sp0*gamma1(i)/(t1(i)**2))
            a21n1(i) = a220(i)
            a210(i) = t4(i) + gamma1(i)*t2(i)
            a2kwt2(i) = tcgpeek*(t2(i)*spp1(i)-t4(i)*spp2(i))
            a2kwg1(i) = tcgpeek*(spp1(i)-gamma1(i)*spp2(i))
            a2k41(i) = -a2kwt2(i)*t1(i)*t4(i)*gamma1(i)/t3(i)
            a2k32(i) = a2k41(i)
            a2k31(i) = -tcgpeek*t4(i)*gamma1(i)*spp1(i)/t1(i)
     &                 +a2kwt2(i)*(n0(i)/t3(i)
     &                    +2.0d0*t1(i)*t2(i)*gamma1(i)/t3(i))
            a2k30a(i) = tcgpeek*gamma1(i)*t4(i)
            a2k23(i) = a2k41(i)
            a2k22(i) = a2k31(i)
            a2k21(i) = 2.0d0*t4(i)*np1(i)/(t1(i)**2)*
     &                    tcgpeek*gamma1(i)*spp1(i)
     &                 +a2kwt2(i)*(-2.0d0*t1(i)+
     &                    (t4(i)*t9(i)-2.0d0*np1(i)*t2(i)+t8(i))*
     &                    gamma1(i))/t3(i)
     &                 +t4(i)*a2kwg1(i)/t1(i)
            a2k21a(i) = a2k30a(i)
            a2k20a(i) = -tcgpeek*(gamma1(i)*t2(i)+t4(i))
            a2k14(i) = 2.0d0*a2k41(i)
            a2k13(i) = 2.0d0*a2k22(i)
            a2k12(i) = 2.0d0*a2k21(i)
            a2k11(i) = -np1(i)/(t1(i)**2)*tcgpeek*gamma1(i)*spp1(i)
     &                 +a2kwt2(i)*(np1(i)
     &                    +(np1(i)**2)*gamma1(i)/t1(i)
     &                    -t9(i)*gamma1(i))/t3(i)
     &                 -a2kwg1(i)/t1(i)
            a2k11(i) = 2.0d0*a2k11(i)
            a2k12a(i) = a2k30a(i)
            a2k11a(i) = a2k20a(i)
            a2k10a(i) = tcgpeek
         end do
c
c     mu2(peek) = mu2 + omega * alpha.r2
c
         call tcg_add_omega_alpha2 (tcgpeek,uind,uinp,
     &                                 r1(:,:,1),r1(:,:,2))
c
c     mutual and direct induced dipole components
c
         ubp(:,:,1) = -0.5d0*(a220(1)*r0(:,:,2)
     &                 + (a221(1)+a2k21(1))*r0(:,:,1)
     &                 + (a222(1)+a231(1)+a2k22(1)+a2k31(1))*p1(:,:,1)
     &                 + (a223(1)+a241(1)+a2k23(1)+a2k41(1))*t2r0(:,:,1)
     &                 + a2k21a(1)*tae(:,:,2) + a2k20a(1)*udirp)
         ubp(:,:,2) = -0.5d0*((a232(1)+a2k32(1))*p1(:,:,1)
     &                            + a2k30a(1)*udirp)
         ubd(:,:,1) = -0.5d0*(a220(2)*r0(:,:,1)
     &                 + (a221(2)+a2k21(2))*r0(:,:,2)
     &                 + (a222(2)+a231(2)+a2k22(2)+a2k31(2))*p1(:,:,2)
     &                 + (a223(2)+a241(2)+a2k23(2)+a2k41(2))*t2r0(:,:,2)
     &                 + a2k21a(2)*tae(:,:,1) + a2k20a(2)*udir)
         ubd(:,:,2) = -0.5d0*((a232(2)+a2k32(2))*p1(:,:,2)
     &                           + a2k30a(2)*udir)
         xde(:,:,1) = (a210(2)*r0(:,:,1) + a21n1(2)*p1(:,:,1)
     &                 + (a211(2)+a2k11(2))*r0(:,:,2)
     &                 + (a212(2)+a2k12(2))*p1(:,:,2)
     &                 + (a213(2)+a2k13(2))*t2r0(:,:,2)
     &                 + (a214(2)+a2k14(2))*t3r0(:,:,2)
     &                 + a2k11a(2)*tae(:,:,1) + a2k12a(2)*t2ae(:,:,1)
     &                 + a2k10a(2)*udir + uind) * 0.5d0
         xde(:,:,2) = (a210(1)*r0(:,:,2) + a21n1(1)*P1(:,:,2)
     &                 + (a211(1)+a2k11(1))*r0(:,:,1)
     &                 + (a212(1)+a2k12(1))*p1(:,:,1)
     &                 + (a213(1)+a2k13(1))*t2r0(:,:,1)
     &                 + (a214(1)+a2k14(1))*t3r0(:,:,1)
     &                 + a2k11a(1)*tae(:,:,2) + a2k12a(1)*t2ae(:,:,2)
     &                 + a2k10a(1)*udirp + uinp) * 0.5d0
         uad(:,:,1) = r0(:,:,1)
         uad(:,:,2) = p1(:,:,1)
         uap(:,:,1) = r0(:,:,2)
         uap(:,:,2) = p1(:,:,2)
         goto 10
      end if
c
c     store induced dipoles from elements of the xde arrays
c
   10 continue
      uind = xde(:,:,1)
      uinp = xde(:,:,2)
c
c     perform deallocation of some local arrays
c
      deallocate (r0)
      deallocate (xde)
      deallocate (p1)
      deallocate (r1)
      deallocate (tae)
      deallocate (t2r0)
      deallocate (t3r0)
      deallocate (t2ae)
      return
      end
c
c
c     ################################
c     ##                            ##
c     ##  subroutine tcg_alphaquad  ##
c     ##                            ##
c     ################################
c
c
c     "tcg_alphaquad" computes the quadratic form, <a*alpha*b>,
c     where alpha is the diagonal atomic polarizability matrix
c
c
      subroutine tcg_alphaquad (scalar,a,b)
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 scalar
      real*8 a(3,*)
      real*8 b(3,*)
c
c
      scalar = 0.0d0
!$OMP PARALLEL default(shared) private(i,j)
!$OMP DO reduction(+:scalar) schedule(guided)
      do i = 1, npole
         do j = 1, 3
         scalar = scalar + a(j,i)*b(j,i)*polarity(i)
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     ###############################
c     ##                           ##
c     ##  subroutine tcg_resource  ##
c     ##                           ##
c     ###############################
c
c
c     "tcg_resource" sets the number of mutual induced dipole
c     pairs based on the passed argument
c
c
      subroutine tcg_resource (order)
      use iounit
      use poltcg
      implicit none
      integer order
c
c
      if (order .lt. 1 .or. order .gt. 2) then
         write (iout,10)
   10    format (/,' TCG_RESOURCE -- Argument ORDER Is Out of Range')
         call fatal
      end if
      tcgnab = order
      if (tcgguess) then
         tcgnab = tcgnab + 1
      end if
      return
      end
c
c
c     ###############################
c     ##                           ##
c     ##  subroutine tcg_converge  ##
c     ##                           ##
c     ###############################
c
c
c     "tcg_converge" checks convergence of the residuals and
c     writes the result to a logical variable
c
c
      subroutine tcg_converge (ifconv,rsdsq1,rsdsq2)
      use polar
      use polpot
      use units
      implicit none
      logical ifconv
      real*8 rsdsq1
      real*8 rsdsq2
      real*8 eps
c
c
      ifconv = .false.
      eps = max(rsdsq1,rsdsq2)
      eps = debye * sqrt(eps/dble(npolar))
      if (eps .lt. poleps) then
         ifconv = .true.
      end if
      return
      end
c
c
c     ##############################
c     ##                          ##
c     ##  subroutine tcg_alpha12  ##
c     ##                          ##
c     ##############################
c
c
c     "tcg_alpha12" computes source1 = alpha.source1 and
c     source2 = alpha.source2
c
c
      subroutine tcg_alpha12 (source1,source2)
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 source1(3,*)
      real*8 source2(3,*)
c
c
!$OMP PARALLEL default(shared) private(i,j)
!$OMP DO schedule(guided)
      do i = 1, npole
         do j = 1, 3
            source1(j,i) = polarity(i) * source1(j,i)
            source2(j,i) = polarity(i) * source2(j,i)
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     ##############################
c     ##                          ##
c     ##  subroutine tcg_alpha22  ##
c     ##                          ##
c     ##############################
c
c
c     "tcg_alpha22" computes result1 = alpha.source1 and
c     result2 = alpha.source2
c
c
      subroutine tcg_alpha22 (source1,source2,result1,result2)
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 source1(3,*)
      real*8 source2(3,*)
      real*8 result1(3,*)
      real*8 result2(3,*)
c
c
!$OMP PARALLEL default(shared) private(i,j)
!$OMP DO schedule(guided)
      do i = 1, npole
         do j = 1, 3
            result1(j,i) = polarity(i) * source1(j,i)
            result2(j,i) = polarity(i) * source2(j,i)
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     #######################################
c     ##                                   ##
c     ##  subroutine tcg_add_omega_alpha2  ##
c     ##                                   ##
c     #######################################
c
c
c     "tcg_add_omega_alpha2" computes u1 = u1 + omega * alpha.r1
c     and u2 = u2 + omega * alpha.r2
c
c
      subroutine tcg_add_omega_alpha2 (omega,u1,u2,r1,r2)
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 omega
      real*8 u1(3,*)
      real*8 u2(3,*)
      real*8 r1(3,*)
      real*8 r2(3,*)
c
c
!$OMP PARALLEL default(shared) private(i,j)
!$OMP DO schedule(guided)
      do i = 1, npole
         do j = 1, 3
            u1(j,i) = u1(j,i) + omega*polarity(i)*r1(j,i)
            u2(j,i) = u2(j,i) + omega*polarity(i)*r2(j,i)
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     ##############################
c     ##                          ##
c     ##  subroutine tcg_dotprod  ##
c     ##                          ##
c     ##############################
c
c
c     "tcg_dotprod" computes the dot product of two vectors
c     of length n elements
c
c
      subroutine tcg_dotprod (scalar,n,a,b)
      implicit none
      integer i,n
      real*8 scalar
      real*8 a(*)
      real*8 b(*)
c
c
c     find value of the scalar dot product
c
      scalar = 0.0d0
!$OMP PARALLEL default(shared) private(i)
!$OMP DO reduction(+:scalar) schedule(guided)
      do i = 1, n
         scalar = scalar + a(i)*b(i)
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     #############################
c     ##                         ##
c     ##  subroutine tcg_ufield  ##
c     ##                         ##
c     #############################
c
c
c     "tcg_ufield" applies -Tu to ind/p and returns v3d/p
c
c
      subroutine tcg_ufield (ind,inp,v3d,v3p)
      use limits
      use mpole
      use polar
      implicit none
      real*8 ind(3,*)
      real*8 inp(3,*)
      real*8 v3d(3,*)
      real*8 v3p(3,*)
c
c
c     swap TCG components with induced dipoles
c
      call tcgswap (uind,uinp,ind,inp)
c
c     compute mutual field
c
      if (use_ewald) then
         call ufield0c (v3d,v3p)
      else if (use_mlist) then
         call ufield0b (v3d,v3p)
      else
         call ufield0a (v3d,v3p)
      end if
c
c     swap TCG components with induced dipoles
c
      call tcgswap (uind,uinp,ind,inp)
      return
      end
c
c
c     #########################
c     ##                     ##
c     ##  subroutine tcg_t0  ##
c     ##                     ##
c     #########################
c
c
c     "tcg_t0" applies T matrix to ind/p, and returns v3d/p
c     T = 1/alpha + Tu
c
c
      subroutine tcg_t0 (ind,inp,v3d,v3p)
      use limits
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 poli,polmin
      real*8 ind(3,*)
      real*8 inp(3,*)
      real*8 v3d(3,*)
      real*8 v3p(3,*)
c
c
c     apply -Tu to ind/p
c
      call tcg_ufield (ind,inp,v3d,v3p)
c
c     compute the 1/alpha contribution
c
      polmin = 0.00000001d0
!$OMP PARALLEL default(shared) private(i,j,poli)
!$OMP DO schedule(guided)
      do i = 1, npole
         if (douind(ipole(i))) then
            poli = max(polmin,polarity(i))
            do j = 1, 3
               v3d(j,i) = ind(j,i)/poli - v3d(j,i)
               v3p(j,i) = inp(j,i)/poli - v3p(j,i)
            end do
         end if
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     ################################################################
c     ##                                                            ##
c     ##  subroutine tcgswap  --  swap induced dipoles for TCG use  ##
c     ##                                                            ##
c     ################################################################
c
c
c     "tcgswap" switches two sets of induced dipole quantities for
c     use with the TCG induced dipole solver
c
c
      subroutine tcgswap (uind1,uinp1,uind2,uinp2)
      use mpole
      implicit none
      integer i,j
      real*8 dterm,pterm
      real*8 uind1(3,*)
      real*8 uinp1(3,*)
      real*8 uind2(3,*)
      real*8 uinp2(3,*)
c
c
c     swap sets of induced dipoles for use with the TCG method
c
!$OMP PARALLEL default(shared) private(i,j,dterm,pterm)
!$OMP DO schedule(guided)
      do i = 1, npole
         do j = 1, 3
            dterm = uind1(j,i)
            pterm = uinp1(j,i)
            uind1(j,i) = uind2(j,i)
            uinp1(j,i) = uinp2(j,i)
            uind2(j,i) = dterm
            uinp2(j,i) = pterm
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
c
c
c     ###########################################################
c     ##                                                       ##
c     ##  subroutine tcg_update_pvec  --  Update TCG P-vector  ##
c     ##                                                       ##
c     ###########################################################
c
c
c     "tcg_update_pvec" computes pvec = alpha.rvec + beta*pvec,
c     if the preconditioner is not used, theb alpha = identity
c
c
      subroutine tcg_update_pvec (pvec,rvec,beta)
      use mpole
      use polar
      implicit none
      integer i,j
      real*8 beta,poli
      real*8 pvec(3,*)
      real*8 rvec(3,*)
c
c
c     computes an updated pvec based on known quantities
c
!$OMP PARALLEL default(shared) private(i,j,poli)
!$OMP DO schedule(guided)
      do i = 1, npole
         poli = polarity(i)
         do j = 1, 3
            pvec(j,i) = poli*rvec(j,i) + beta*pvec(j,i)
         end do
      end do
!$OMP END DO
!$OMP END PARALLEL
      return
      end
