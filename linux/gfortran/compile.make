#
#
#  #############################################################
#  ##                                                         ##
#  ##  compile.make  --  compile each of the Tinker routines  ##
#  ##             (GNU gfortran for Linux Version)            ##
#  ##                                                         ##
#  #############################################################
#
#
#  compile all the modules; "sizes" must be first since it is used
#  to set static array dimensions in many of the other modules
#
#
gfortran -c -Ofast -mavx -fopenmp sizes.f
gfortran -c -Ofast -mavx -fopenmp action.f
gfortran -c -Ofast -mavx -fopenmp align.f
gfortran -c -Ofast -mavx -fopenmp analyz.f
gfortran -c -Ofast -mavx -fopenmp angang.f
gfortran -c -Ofast -mavx -fopenmp angbnd.f
gfortran -c -Ofast -mavx -fopenmp angpot.f
gfortran -c -Ofast -mavx -fopenmp angtor.f
gfortran -c -Ofast -mavx -fopenmp argue.f
gfortran -c -Ofast -mavx -fopenmp ascii.f
gfortran -c -Ofast -mavx -fopenmp atmlst.f
gfortran -c -Ofast -mavx -fopenmp atomid.f
gfortran -c -Ofast -mavx -fopenmp atoms.f
gfortran -c -Ofast -mavx -fopenmp bath.f
gfortran -c -Ofast -mavx -fopenmp bitor.f
gfortran -c -Ofast -mavx -fopenmp bndpot.f
gfortran -c -Ofast -mavx -fopenmp bndstr.f
gfortran -c -Ofast -mavx -fopenmp bound.f
gfortran -c -Ofast -mavx -fopenmp boxes.f
gfortran -c -Ofast -mavx -fopenmp cell.f
gfortran -c -Ofast -mavx -fopenmp charge.f
gfortran -c -Ofast -mavx -fopenmp chgpot.f
gfortran -c -Ofast -mavx -fopenmp chrono.f
gfortran -c -Ofast -mavx -fopenmp chunks.f
gfortran -c -Ofast -mavx -fopenmp couple.f
gfortran -c -Ofast -mavx -fopenmp deriv.f
gfortran -c -Ofast -mavx -fopenmp dipole.f
gfortran -c -Ofast -mavx -fopenmp disgeo.f
gfortran -c -Ofast -mavx -fopenmp dma.f
gfortran -c -Ofast -mavx -fopenmp domega.f
gfortran -c -Ofast -mavx -fopenmp energi.f
gfortran -c -Ofast -mavx -fopenmp ewald.f
gfortran -c -Ofast -mavx -fopenmp faces.f
gfortran -c -Ofast -mavx -fopenmp fft.f
gfortran -c -Ofast -mavx -fopenmp fields.f
gfortran -c -Ofast -mavx -fopenmp files.f
gfortran -c -Ofast -mavx -fopenmp fracs.f
gfortran -c -Ofast -mavx -fopenmp freeze.f
gfortran -c -Ofast -mavx -fopenmp gkstuf.f
gfortran -c -Ofast -mavx -fopenmp group.f
gfortran -c -Ofast -mavx -fopenmp hescut.f
gfortran -c -Ofast -mavx -fopenmp hessn.f
gfortran -c -Ofast -mavx -fopenmp hpmf.f
gfortran -c -Ofast -mavx -fopenmp ielscf.f
gfortran -c -Ofast -mavx -fopenmp improp.f
gfortran -c -Ofast -mavx -fopenmp imptor.f
gfortran -c -Ofast -mavx -fopenmp inform.f
gfortran -c -Ofast -mavx -fopenmp inter.f
gfortran -c -Ofast -mavx -fopenmp iounit.f
gfortran -c -Ofast -mavx -fopenmp kanang.f
gfortran -c -Ofast -mavx -fopenmp kangs.f
gfortran -c -Ofast -mavx -fopenmp kantor.f
gfortran -c -Ofast -mavx -fopenmp katoms.f
gfortran -c -Ofast -mavx -fopenmp kbonds.f
gfortran -c -Ofast -mavx -fopenmp kchrge.f
gfortran -c -Ofast -mavx -fopenmp kdipol.f
gfortran -c -Ofast -mavx -fopenmp keys.f
gfortran -c -Ofast -mavx -fopenmp khbond.f
gfortran -c -Ofast -mavx -fopenmp kiprop.f
gfortran -c -Ofast -mavx -fopenmp kitors.f
gfortran -c -Ofast -mavx -fopenmp kmulti.f
gfortran -c -Ofast -mavx -fopenmp kopbnd.f
gfortran -c -Ofast -mavx -fopenmp kopdst.f
gfortran -c -Ofast -mavx -fopenmp korbs.f
gfortran -c -Ofast -mavx -fopenmp kpitor.f
gfortran -c -Ofast -mavx -fopenmp kpolr.f
gfortran -c -Ofast -mavx -fopenmp kstbnd.f
gfortran -c -Ofast -mavx -fopenmp ksttor.f
gfortran -c -Ofast -mavx -fopenmp ktorsn.f
gfortran -c -Ofast -mavx -fopenmp ktrtor.f
gfortran -c -Ofast -mavx -fopenmp kurybr.f
gfortran -c -Ofast -mavx -fopenmp kvdwpr.f
gfortran -c -Ofast -mavx -fopenmp kvdws.f
gfortran -c -Ofast -mavx -fopenmp light.f
gfortran -c -Ofast -mavx -fopenmp limits.f
gfortran -c -Ofast -mavx -fopenmp linmin.f
gfortran -c -Ofast -mavx -fopenmp math.f
gfortran -c -Ofast -mavx -fopenmp mdstuf.f
gfortran -c -Ofast -mavx -fopenmp merck.f
gfortran -c -Ofast -mavx -fopenmp minima.f
gfortran -c -Ofast -mavx -fopenmp molcul.f
gfortran -c -Ofast -mavx -fopenmp moldyn.f
gfortran -c -Ofast -mavx -fopenmp moment.f
gfortran -c -Ofast -mavx -fopenmp mplpot.f
gfortran -c -Ofast -mavx -fopenmp mpole.f
gfortran -c -Ofast -mavx -fopenmp mrecip.f
gfortran -c -Ofast -mavx -fopenmp mutant.f
gfortran -c -Ofast -mavx -fopenmp neigh.f
gfortran -c -Ofast -mavx -fopenmp nonpol.f
gfortran -c -Ofast -mavx -fopenmp nucleo.f
gfortran -c -Ofast -mavx -fopenmp omega.f
gfortran -c -Ofast -mavx -fopenmp opbend.f
gfortran -c -Ofast -mavx -fopenmp opdist.f
gfortran -c -Ofast -mavx -fopenmp openmp.f
gfortran -c -Ofast -mavx -fopenmp orbits.f
gfortran -c -Ofast -mavx -fopenmp output.f
gfortran -c -Ofast -mavx -fopenmp params.f
gfortran -c -Ofast -mavx -fopenmp paths.f
gfortran -c -Ofast -mavx -fopenmp pbstuf.f
gfortran -c -Ofast -mavx -fopenmp pdb.f
gfortran -c -Ofast -mavx -fopenmp phipsi.f
gfortran -c -Ofast -mavx -fopenmp piorbs.f
gfortran -c -Ofast -mavx -fopenmp pistuf.f
gfortran -c -Ofast -mavx -fopenmp pitors.f
gfortran -c -Ofast -mavx -fopenmp pme.f
gfortran -c -Ofast -mavx -fopenmp polar.f
gfortran -c -Ofast -mavx -fopenmp polgrp.f
gfortran -c -Ofast -mavx -fopenmp polopt.f
gfortran -c -Ofast -mavx -fopenmp polpot.f
gfortran -c -Ofast -mavx -fopenmp poltcg.f
gfortran -c -Ofast -mavx -fopenmp potent.f
gfortran -c -Ofast -mavx -fopenmp potfit.f
gfortran -c -Ofast -mavx -fopenmp precis.f
gfortran -c -Ofast -mavx -fopenmp ptable.f
gfortran -c -Ofast -mavx -fopenmp qmstuf.f
gfortran -c -Ofast -mavx -fopenmp refer.f
gfortran -c -Ofast -mavx -fopenmp resdue.f
gfortran -c -Ofast -mavx -fopenmp restrn.f
gfortran -c -Ofast -mavx -fopenmp rgddyn.f
gfortran -c -Ofast -mavx -fopenmp rigid.f
gfortran -c -Ofast -mavx -fopenmp ring.f
gfortran -c -Ofast -mavx -fopenmp rotbnd.f
gfortran -c -Ofast -mavx -fopenmp rxnfld.f
gfortran -c -Ofast -mavx -fopenmp rxnpot.f
gfortran -c -Ofast -mavx -fopenmp scales.f
gfortran -c -Ofast -mavx -fopenmp sequen.f
gfortran -c -Ofast -mavx -fopenmp shunt.f
gfortran -c -Ofast -mavx -fopenmp socket.f
gfortran -c -Ofast -mavx -fopenmp solute.f
gfortran -c -Ofast -mavx -fopenmp stodyn.f
gfortran -c -Ofast -mavx -fopenmp strbnd.f
gfortran -c -Ofast -mavx -fopenmp strtor.f
gfortran -c -Ofast -mavx -fopenmp syntrn.f
gfortran -c -Ofast -mavx -fopenmp tarray.f
gfortran -c -Ofast -mavx -fopenmp titles.f
gfortran -c -Ofast -mavx -fopenmp torpot.f
gfortran -c -Ofast -mavx -fopenmp tors.f
gfortran -c -Ofast -mavx -fopenmp tortor.f
gfortran -c -Ofast -mavx -fopenmp tree.f
gfortran -c -Ofast -mavx -fopenmp units.f
gfortran -c -Ofast -mavx -fopenmp uprior.f
gfortran -c -Ofast -mavx -fopenmp urey.f
gfortran -c -Ofast -mavx -fopenmp urypot.f
gfortran -c -Ofast -mavx -fopenmp usage.f
gfortran -c -Ofast -mavx -fopenmp usolve.f
gfortran -c -Ofast -mavx -fopenmp valfit.f
gfortran -c -Ofast -mavx -fopenmp vdw.f
gfortran -c -Ofast -mavx -fopenmp vdwpot.f
gfortran -c -Ofast -mavx -fopenmp vibs.f
gfortran -c -Ofast -mavx -fopenmp virial.f
gfortran -c -Ofast -mavx -fopenmp warp.f
gfortran -c -Ofast -mavx -fopenmp xtals.f
gfortran -c -Ofast -mavx -fopenmp zclose.f
gfortran -c -Ofast -mavx -fopenmp zcoord.f
#
#  now compile separately each of the Fortran source files
#
gfortran -c -Ofast -mavx -fopenmp active.f
gfortran -c -Ofast -mavx -fopenmp alchemy.f
gfortran -c -Ofast -mavx -fopenmp analysis.f
gfortran -c -Ofast -mavx -fopenmp analyze.f
gfortran -c -Ofast -mavx -fopenmp angles.f
gfortran -c -Ofast -mavx -fopenmp anneal.f
gfortran -c -Ofast -mavx -fopenmp archive.f
gfortran -c -Ofast -mavx -fopenmp attach.f
gfortran -c -Ofast -mavx -fopenmp baoab.f
gfortran -c -Ofast -mavx -fopenmp bar.f
gfortran -c -Ofast -mavx -fopenmp basefile.f
gfortran -c -Ofast -mavx -fopenmp beeman.f
gfortran -c -Ofast -mavx -fopenmp bicubic.f
gfortran -c -Ofast -mavx -fopenmp bitors.f
gfortran -c -Ofast -mavx -fopenmp bonds.f
gfortran -c -Ofast -mavx -fopenmp born.f
gfortran -c -Ofast -mavx -fopenmp bounds.f
gfortran -c -Ofast -mavx -fopenmp bussi.f
gfortran -c -Ofast -mavx -fopenmp calendar.f
gfortran -c -Ofast -mavx -fopenmp center.f
gfortran -c -Ofast -mavx -fopenmp chkpole.f
gfortran -c -Ofast -mavx -fopenmp chkring.f
gfortran -c -Ofast -mavx -fopenmp chkxyz.f
gfortran -c -Ofast -mavx -fopenmp cholesky.f
gfortran -c -Ofast -mavx -fopenmp clock.f
gfortran -c -Ofast -mavx -fopenmp cluster.f
gfortran -c -Ofast -mavx -fopenmp column.f
gfortran -c -Ofast -mavx -fopenmp command.f
gfortran -c -Ofast -mavx -fopenmp connect.f
gfortran -c -Ofast -mavx -fopenmp connolly.f
gfortran -c -Ofast -mavx -fopenmp control.f
gfortran -c -Ofast -mavx -fopenmp correlate.f
gfortran -c -Ofast -mavx -fopenmp crystal.f
gfortran -c -Ofast -mavx -fopenmp cspline.f
gfortran -c -Ofast -mavx -fopenmp cutoffs.f
gfortran -c -Ofast -mavx -fopenmp deflate.f
gfortran -c -Ofast -mavx -fopenmp delete.f
gfortran -c -Ofast -mavx -fopenmp diagq.f
gfortran -c -Ofast -mavx -fopenmp diffeq.f
gfortran -c -Ofast -mavx -fopenmp diffuse.f
gfortran -c -Ofast -mavx -fopenmp distgeom.f
gfortran -c -Ofast -mavx -fopenmp document.f
gfortran -c -Ofast -mavx -fopenmp dynamic.f
gfortran -c -Ofast -mavx -fopenmp eangang.f
gfortran -c -Ofast -mavx -fopenmp eangang1.f
gfortran -c -Ofast -mavx -fopenmp eangang2.f
gfortran -c -Ofast -mavx -fopenmp eangang3.f
gfortran -c -Ofast -mavx -fopenmp eangle.f
gfortran -c -Ofast -mavx -fopenmp eangle1.f
gfortran -c -Ofast -mavx -fopenmp eangle2.f
gfortran -c -Ofast -mavx -fopenmp eangle3.f
gfortran -c -Ofast -mavx -fopenmp eangtor.f
gfortran -c -Ofast -mavx -fopenmp eangtor1.f
gfortran -c -Ofast -mavx -fopenmp eangtor2.f
gfortran -c -Ofast -mavx -fopenmp eangtor3.f
gfortran -c -Ofast -mavx -fopenmp ebond.f
gfortran -c -Ofast -mavx -fopenmp ebond1.f
gfortran -c -Ofast -mavx -fopenmp ebond2.f
gfortran -c -Ofast -mavx -fopenmp ebond3.f
gfortran -c -Ofast -mavx -fopenmp ebuck.f
gfortran -c -Ofast -mavx -fopenmp ebuck1.f
gfortran -c -Ofast -mavx -fopenmp ebuck2.f
gfortran -c -Ofast -mavx -fopenmp ebuck3.f
gfortran -c -Ofast -mavx -fopenmp echarge.f
gfortran -c -Ofast -mavx -fopenmp echarge1.f
gfortran -c -Ofast -mavx -fopenmp echarge2.f
gfortran -c -Ofast -mavx -fopenmp echarge3.f
gfortran -c -Ofast -mavx -fopenmp echgdpl.f
gfortran -c -Ofast -mavx -fopenmp echgdpl1.f
gfortran -c -Ofast -mavx -fopenmp echgdpl2.f
gfortran -c -Ofast -mavx -fopenmp echgdpl3.f
gfortran -c -Ofast -mavx -fopenmp edipole.f
gfortran -c -Ofast -mavx -fopenmp edipole1.f
gfortran -c -Ofast -mavx -fopenmp edipole2.f
gfortran -c -Ofast -mavx -fopenmp edipole3.f
gfortran -c -Ofast -mavx -fopenmp egauss.f
gfortran -c -Ofast -mavx -fopenmp egauss1.f
gfortran -c -Ofast -mavx -fopenmp egauss2.f
gfortran -c -Ofast -mavx -fopenmp egauss3.f
gfortran -c -Ofast -mavx -fopenmp egeom.f
gfortran -c -Ofast -mavx -fopenmp egeom1.f
gfortran -c -Ofast -mavx -fopenmp egeom2.f
gfortran -c -Ofast -mavx -fopenmp egeom3.f
gfortran -c -Ofast -mavx -fopenmp ehal.f
gfortran -c -Ofast -mavx -fopenmp ehal1.f
gfortran -c -Ofast -mavx -fopenmp ehal2.f
gfortran -c -Ofast -mavx -fopenmp ehal3.f
gfortran -c -Ofast -mavx -fopenmp eimprop.f
gfortran -c -Ofast -mavx -fopenmp eimprop1.f
gfortran -c -Ofast -mavx -fopenmp eimprop2.f
gfortran -c -Ofast -mavx -fopenmp eimprop3.f
gfortran -c -Ofast -mavx -fopenmp eimptor.f
gfortran -c -Ofast -mavx -fopenmp eimptor1.f
gfortran -c -Ofast -mavx -fopenmp eimptor2.f
gfortran -c -Ofast -mavx -fopenmp eimptor3.f
gfortran -c -Ofast -mavx -fopenmp elj.f
gfortran -c -Ofast -mavx -fopenmp elj1.f
gfortran -c -Ofast -mavx -fopenmp elj2.f
gfortran -c -Ofast -mavx -fopenmp elj3.f
gfortran -c -Ofast -mavx -fopenmp embed.f
gfortran -c -Ofast -mavx -fopenmp emetal.f
gfortran -c -Ofast -mavx -fopenmp emetal1.f
gfortran -c -Ofast -mavx -fopenmp emetal2.f
gfortran -c -Ofast -mavx -fopenmp emetal3.f
gfortran -c -Ofast -mavx -fopenmp emm3hb.f
gfortran -c -Ofast -mavx -fopenmp emm3hb1.f
gfortran -c -Ofast -mavx -fopenmp emm3hb2.f
gfortran -c -Ofast -mavx -fopenmp emm3hb3.f
gfortran -c -Ofast -mavx -fopenmp empole.f
gfortran -c -Ofast -mavx -fopenmp empole1.f
gfortran -c -Ofast -mavx -fopenmp empole2.f
gfortran -c -Ofast -mavx -fopenmp empole3.f
gfortran -c -Ofast -mavx -fopenmp energy.f
gfortran -c -Ofast -mavx -fopenmp eopbend.f
gfortran -c -Ofast -mavx -fopenmp eopbend1.f
gfortran -c -Ofast -mavx -fopenmp eopbend2.f
gfortran -c -Ofast -mavx -fopenmp eopbend3.f
gfortran -c -Ofast -mavx -fopenmp eopdist.f
gfortran -c -Ofast -mavx -fopenmp eopdist1.f
gfortran -c -Ofast -mavx -fopenmp eopdist2.f
gfortran -c -Ofast -mavx -fopenmp eopdist3.f
gfortran -c -Ofast -mavx -fopenmp epitors.f
gfortran -c -Ofast -mavx -fopenmp epitors1.f
gfortran -c -Ofast -mavx -fopenmp epitors2.f
gfortran -c -Ofast -mavx -fopenmp epitors3.f
gfortran -c -Ofast -mavx -fopenmp epolar.f
gfortran -c -Ofast -mavx -fopenmp epolar1.f
gfortran -c -Ofast -mavx -fopenmp epolar2.f
gfortran -c -Ofast -mavx -fopenmp epolar3.f
gfortran -c -Ofast -mavx -fopenmp erf.f
gfortran -c -Ofast -mavx -fopenmp erxnfld.f
gfortran -c -Ofast -mavx -fopenmp erxnfld1.f
gfortran -c -Ofast -mavx -fopenmp erxnfld2.f
gfortran -c -Ofast -mavx -fopenmp erxnfld3.f
gfortran -c -Ofast -mavx -fopenmp esolv.f
gfortran -c -Ofast -mavx -fopenmp esolv1.f
gfortran -c -Ofast -mavx -fopenmp esolv2.f
gfortran -c -Ofast -mavx -fopenmp esolv3.f
gfortran -c -Ofast -mavx -fopenmp estrbnd.f
gfortran -c -Ofast -mavx -fopenmp estrbnd1.f
gfortran -c -Ofast -mavx -fopenmp estrbnd2.f
gfortran -c -Ofast -mavx -fopenmp estrbnd3.f
gfortran -c -Ofast -mavx -fopenmp estrtor.f
gfortran -c -Ofast -mavx -fopenmp estrtor1.f
gfortran -c -Ofast -mavx -fopenmp estrtor2.f
gfortran -c -Ofast -mavx -fopenmp estrtor3.f
gfortran -c -Ofast -mavx -fopenmp etors.f
gfortran -c -Ofast -mavx -fopenmp etors1.f
gfortran -c -Ofast -mavx -fopenmp etors2.f
gfortran -c -Ofast -mavx -fopenmp etors3.f
gfortran -c -Ofast -mavx -fopenmp etortor.f
gfortran -c -Ofast -mavx -fopenmp etortor1.f
gfortran -c -Ofast -mavx -fopenmp etortor2.f
gfortran -c -Ofast -mavx -fopenmp etortor3.f
gfortran -c -Ofast -mavx -fopenmp eurey.f
gfortran -c -Ofast -mavx -fopenmp eurey1.f
gfortran -c -Ofast -mavx -fopenmp eurey2.f
gfortran -c -Ofast -mavx -fopenmp eurey3.f
gfortran -c -Ofast -mavx -fopenmp evcorr.f
gfortran -c -Ofast -mavx -fopenmp extra.f
gfortran -c -Ofast -mavx -fopenmp extra1.f
gfortran -c -Ofast -mavx -fopenmp extra2.f
gfortran -c -Ofast -mavx -fopenmp extra3.f
gfortran -c -Ofast -mavx -fopenmp fatal.f
gfortran -c -Ofast -mavx -fopenmp fft3d.f
gfortran -c -Ofast -mavx -fopenmp fftpack.f
gfortran -c -Ofast -mavx -fopenmp field.f
gfortran -c -Ofast -mavx -fopenmp final.f
gfortran -c -Ofast -mavx -fopenmp flatten.f
gfortran -c -Ofast -mavx -fopenmp freeunit.f
gfortran -c -Ofast -mavx -fopenmp gda.f
gfortran -c -Ofast -mavx -fopenmp geometry.f
gfortran -c -Ofast -mavx -fopenmp getarc.f
gfortran -c -Ofast -mavx -fopenmp getint.f
gfortran -c -Ofast -mavx -fopenmp getkey.f
gfortran -c -Ofast -mavx -fopenmp getmol.f
gfortran -c -Ofast -mavx -fopenmp getmol2.f
gfortran -c -Ofast -mavx -fopenmp getnumb.f
gfortran -c -Ofast -mavx -fopenmp getpdb.f
gfortran -c -Ofast -mavx -fopenmp getprm.f
gfortran -c -Ofast -mavx -fopenmp getref.f
gfortran -c -Ofast -mavx -fopenmp getstring.f
gfortran -c -Ofast -mavx -fopenmp gettext.f
gfortran -c -Ofast -mavx -fopenmp getword.f
gfortran -c -Ofast -mavx -fopenmp getxyz.f
gfortran -c -Ofast -mavx -fopenmp ghmcstep.f
gfortran -c -Ofast -mavx -fopenmp gradient.f
gfortran -c -Ofast -mavx -fopenmp gradrgd.f
gfortran -c -Ofast -mavx -fopenmp gradrot.f
gfortran -c -Ofast -mavx -fopenmp groups.f
gfortran -c -Ofast -mavx -fopenmp grpline.f
gfortran -c -Ofast -mavx -fopenmp gyrate.f
gfortran -c -Ofast -mavx -fopenmp hessian.f
gfortran -c -Ofast -mavx -fopenmp hessrgd.f
gfortran -c -Ofast -mavx -fopenmp hessrot.f
gfortran -c -Ofast -mavx -fopenmp hybrid.f
gfortran -c -Ofast -mavx -fopenmp image.f
gfortran -c -Ofast -mavx -fopenmp impose.f
gfortran -c -Ofast -mavx -fopenmp induce.f
gfortran -c -Ofast -mavx -fopenmp inertia.f
gfortran -c -Ofast -mavx -fopenmp initatom.f
gfortran -c -Ofast -mavx -fopenmp initial.f
gfortran -c -Ofast -mavx -fopenmp initprm.f
gfortran -c -Ofast -mavx -fopenmp initres.f
gfortran -c -Ofast -mavx -fopenmp initrot.f
gfortran -c -Ofast -mavx -fopenmp insert.f
gfortran -c -Ofast -mavx -fopenmp intedit.f
gfortran -c -Ofast -mavx -fopenmp intxyz.f
gfortran -c -Ofast -mavx -fopenmp invbeta.f
gfortran -c -Ofast -mavx -fopenmp invert.f
gfortran -c -Ofast -mavx -fopenmp jacobi.f
gfortran -c -Ofast -mavx -fopenmp kangang.f
gfortran -c -Ofast -mavx -fopenmp kangle.f
gfortran -c -Ofast -mavx -fopenmp kangtor.f
gfortran -c -Ofast -mavx -fopenmp katom.f
gfortran -c -Ofast -mavx -fopenmp kbond.f
gfortran -c -Ofast -mavx -fopenmp kcharge.f
gfortran -c -Ofast -mavx -fopenmp kdipole.f
gfortran -c -Ofast -mavx -fopenmp kewald.f
gfortran -c -Ofast -mavx -fopenmp kextra.f
gfortran -c -Ofast -mavx -fopenmp kgeom.f
gfortran -c -Ofast -mavx -fopenmp kimprop.f
gfortran -c -Ofast -mavx -fopenmp kimptor.f
gfortran -c -Ofast -mavx -fopenmp kinetic.f
gfortran -c -Ofast -mavx -fopenmp kmetal.f
gfortran -c -Ofast -mavx -fopenmp kmpole.f
gfortran -c -Ofast -mavx -fopenmp kopbend.f
gfortran -c -Ofast -mavx -fopenmp kopdist.f
gfortran -c -Ofast -mavx -fopenmp korbit.f
gfortran -c -Ofast -mavx -fopenmp kpitors.f
gfortran -c -Ofast -mavx -fopenmp kpolar.f
gfortran -c -Ofast -mavx -fopenmp ksolv.f
gfortran -c -Ofast -mavx -fopenmp kstrbnd.f
gfortran -c -Ofast -mavx -fopenmp kstrtor.f
gfortran -c -Ofast -mavx -fopenmp ktors.f
gfortran -c -Ofast -mavx -fopenmp ktortor.f
gfortran -c -Ofast -mavx -fopenmp kurey.f
gfortran -c -Ofast -mavx -fopenmp kvdw.f
gfortran -c -Ofast -mavx -fopenmp lattice.f
gfortran -c -Ofast -mavx -fopenmp lbfgs.f
gfortran -c -Ofast -mavx -fopenmp lights.f
gfortran -c -Ofast -mavx -fopenmp makeint.f
gfortran -c -Ofast -mavx -fopenmp makeref.f
gfortran -c -Ofast -mavx -fopenmp makexyz.f
gfortran -c -Ofast -mavx -fopenmp maxwell.f
gfortran -c -Ofast -mavx -fopenmp mdinit.f
gfortran -c -Ofast -mavx -fopenmp mdrest.f
gfortran -c -Ofast -mavx -fopenmp mdsave.f
gfortran -c -Ofast -mavx -fopenmp mdstat.f
gfortran -c -Ofast -mavx -fopenmp mechanic.f
gfortran -c -Ofast -mavx -fopenmp merge.f
gfortran -c -Ofast -mavx -fopenmp minimize.f
gfortran -c -Ofast -mavx -fopenmp minirot.f
gfortran -c -Ofast -mavx -fopenmp minrigid.f
gfortran -c -Ofast -mavx -fopenmp mol2xyz.f
gfortran -c -Ofast -mavx -fopenmp molecule.f
gfortran -c -Ofast -mavx -fopenmp molxyz.f
gfortran -c -Ofast -mavx -fopenmp moments.f
gfortran -c -Ofast -mavx -fopenmp monte.f
gfortran -c -Ofast -mavx -fopenmp mutate.f
gfortran -c -Ofast -mavx -fopenmp nblist.f
gfortran -c -Ofast -mavx -fopenmp newton.f
gfortran -c -Ofast -mavx -fopenmp newtrot.f
gfortran -c -Ofast -mavx -fopenmp nextarg.f
gfortran -c -Ofast -mavx -fopenmp nexttext.f
gfortran -c -Ofast -mavx -fopenmp nose.f
gfortran -c -Ofast -mavx -fopenmp nspline.f
gfortran -c -Ofast -mavx -fopenmp nucleic.f
gfortran -c -Ofast -mavx -fopenmp number.f
gfortran -c -Ofast -mavx -fopenmp numeral.f
gfortran -c -Ofast -mavx -fopenmp numgrad.f
gfortran -c -Ofast -mavx -fopenmp ocvm.f
gfortran -c -Ofast -mavx -fopenmp openend.f
gfortran -c -Ofast -mavx -fopenmp optimize.f
gfortran -c -Ofast -mavx -fopenmp optirot.f
gfortran -c -Ofast -mavx -fopenmp optrigid.f
gfortran -c -Ofast -mavx -fopenmp optsave.f
gfortran -c -Ofast -mavx -fopenmp orbital.f
gfortran -c -Ofast -mavx -fopenmp orient.f
gfortran -c -Ofast -mavx -fopenmp orthog.f
gfortran -c -Ofast -mavx -fopenmp overlap.f
gfortran -c -Ofast -mavx -fopenmp path.f
gfortran -c -Ofast -mavx -fopenmp pdbxyz.f
gfortran -c -Ofast -mavx -fopenmp picalc.f
gfortran -c -Ofast -mavx -fopenmp pmestuf.f
gfortran -c -Ofast -mavx -fopenmp pmpb.f
gfortran -c -Ofast -mavx -fopenmp polarize.f
gfortran -c -Ofast -mavx -fopenmp poledit.f
gfortran -c -Ofast -mavx -fopenmp polymer.f
gfortran -c -Ofast -mavx -fopenmp potential.f
gfortran -c -Ofast -mavx -fopenmp precise.f
gfortran -c -Ofast -mavx -fopenmp pressure.f
gfortran -c -Ofast -mavx -fopenmp prmedit.f
gfortran -c -Ofast -mavx -fopenmp prmkey.f
gfortran -c -Ofast -mavx -fopenmp promo.f
gfortran -c -Ofast -mavx -fopenmp protein.f
gfortran -c -Ofast -mavx -fopenmp prtdyn.f
gfortran -c -Ofast -mavx -fopenmp prterr.f
gfortran -c -Ofast -mavx -fopenmp prtint.f
gfortran -c -Ofast -mavx -fopenmp prtmol2.f
gfortran -c -Ofast -mavx -fopenmp prtpdb.f
gfortran -c -Ofast -mavx -fopenmp prtprm.f
gfortran -c -Ofast -mavx -fopenmp prtseq.f
gfortran -c -Ofast -mavx -fopenmp prtxyz.f
gfortran -c -Ofast -mavx -fopenmp pss.f
gfortran -c -Ofast -mavx -fopenmp pssrigid.f
gfortran -c -Ofast -mavx -fopenmp pssrot.f
gfortran -c -Ofast -mavx -fopenmp qrfact.f
gfortran -c -Ofast -mavx -fopenmp quatfit.f
gfortran -c -Ofast -mavx -fopenmp radial.f
gfortran -c -Ofast -mavx -fopenmp random.f
gfortran -c -Ofast -mavx -fopenmp rattle.f
gfortran -c -Ofast -mavx -fopenmp readdyn.f
gfortran -c -Ofast -mavx -fopenmp readgau.f
gfortran -c -Ofast -mavx -fopenmp readgdma.f
gfortran -c -Ofast -mavx -fopenmp readint.f
gfortran -c -Ofast -mavx -fopenmp readmol.f
gfortran -c -Ofast -mavx -fopenmp readmol2.f
gfortran -c -Ofast -mavx -fopenmp readpdb.f
gfortran -c -Ofast -mavx -fopenmp readprm.f
gfortran -c -Ofast -mavx -fopenmp readseq.f
gfortran -c -Ofast -mavx -fopenmp readxyz.f
gfortran -c -Ofast -mavx -fopenmp replica.f
gfortran -c -Ofast -mavx -fopenmp respa.f
gfortran -c -Ofast -mavx -fopenmp rgdstep.f
gfortran -c -Ofast -mavx -fopenmp rings.f
gfortran -c -Ofast -mavx -fopenmp rmsfit.f
gfortran -c -Ofast -mavx -fopenmp rotlist.f
gfortran -c -Ofast -mavx -fopenmp rotpole.f
gfortran -c -Ofast -mavx -fopenmp saddle.f
gfortran -c -Ofast -mavx -fopenmp scan.f
gfortran -c -Ofast -mavx -fopenmp sdstep.f
gfortran -c -Ofast -mavx -fopenmp search.f
gfortran -c -Ofast -mavx -fopenmp server.f
gfortran -c -Ofast -mavx -fopenmp shakeup.f
gfortran -c -Ofast -mavx -fopenmp sigmoid.f
gfortran -c -Ofast -mavx -fopenmp simplex.f
gfortran -c -Ofast -mavx -fopenmp sktstuf.f
gfortran -c -Ofast -mavx -fopenmp sniffer.f
gfortran -c -Ofast -mavx -fopenmp sort.f
gfortran -c -Ofast -mavx -fopenmp spacefill.f
gfortran -c -Ofast -mavx -fopenmp spectrum.f
gfortran -c -Ofast -mavx -fopenmp square.f
gfortran -c -Ofast -mavx -fopenmp suffix.f
gfortran -c -Ofast -mavx -fopenmp superpose.f
gfortran -c -Ofast -mavx -fopenmp surface.f
gfortran -c -Ofast -mavx -fopenmp surfatom.f
gfortran -c -Ofast -mavx -fopenmp switch.f
gfortran -c -Ofast -mavx -fopenmp tcgstuf.f
gfortran -c -Ofast -mavx -fopenmp temper.f
gfortran -c -Ofast -mavx -fopenmp testgrad.f
gfortran -c -Ofast -mavx -fopenmp testhess.f
gfortran -c -Ofast -mavx -fopenmp testpair.f
gfortran -c -Ofast -mavx -fopenmp testpol.f
gfortran -c -Ofast -mavx -fopenmp testrot.f
gfortran -c -Ofast -mavx -fopenmp testvir.f
gfortran -c -Ofast -mavx -fopenmp timer.f
gfortran -c -Ofast -mavx -fopenmp timerot.f
gfortran -c -Ofast -mavx -fopenmp tncg.f
gfortran -c -Ofast -mavx -fopenmp torphase.f
gfortran -c -Ofast -mavx -fopenmp torque.f
gfortran -c -Ofast -mavx -fopenmp torsfit.f
gfortran -c -Ofast -mavx -fopenmp torsions.f
gfortran -c -Ofast -mavx -fopenmp trimtext.f
gfortran -c -Ofast -mavx -fopenmp unitcell.f
gfortran -c -Ofast -mavx -fopenmp valence.f
gfortran -c -Ofast -mavx -fopenmp verlet.f
gfortran -c -Ofast -mavx -fopenmp version.f
gfortran -c -Ofast -mavx -fopenmp vibbig.f
gfortran -c -Ofast -mavx -fopenmp vibrate.f
gfortran -c -Ofast -mavx -fopenmp vibrot.f
gfortran -c -Ofast -mavx -fopenmp volume.f
gfortran -c -Ofast -mavx -fopenmp xtalfit.f
gfortran -c -Ofast -mavx -fopenmp xtalmin.f
gfortran -c -Ofast -mavx -fopenmp xyzatm.f
gfortran -c -Ofast -mavx -fopenmp xyzedit.f
gfortran -c -Ofast -mavx -fopenmp xyzint.f
gfortran -c -Ofast -mavx -fopenmp xyzmol2.f
gfortran -c -Ofast -mavx -fopenmp xyzpdb.f
gfortran -c -Ofast -mavx -fopenmp zatom.f
