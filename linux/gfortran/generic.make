#
#
#  #################################################################
#  ##                                                             ##
#  ##  generic.make  --  compile Tinker routines for generic CPU  ##
#  ##               (GNU gfortran for Linux Version)              ##
#  ##                                                             ##
#  #################################################################
#
#
#  compile all the modules; "sizes" must be first since it is used
#  to set static array dimensions in many of the other modules
#
#
gfortran -c -Ofast -msse3 -fopenmp sizes.f
gfortran -c -Ofast -msse3 -fopenmp action.f
gfortran -c -Ofast -msse3 -fopenmp align.f
gfortran -c -Ofast -msse3 -fopenmp analyz.f
gfortran -c -Ofast -msse3 -fopenmp angang.f
gfortran -c -Ofast -msse3 -fopenmp angbnd.f
gfortran -c -Ofast -msse3 -fopenmp angpot.f
gfortran -c -Ofast -msse3 -fopenmp angtor.f
gfortran -c -Ofast -msse3 -fopenmp argue.f
gfortran -c -Ofast -msse3 -fopenmp ascii.f
gfortran -c -Ofast -msse3 -fopenmp atmlst.f
gfortran -c -Ofast -msse3 -fopenmp atomid.f
gfortran -c -Ofast -msse3 -fopenmp atoms.f
gfortran -c -Ofast -msse3 -fopenmp bath.f
gfortran -c -Ofast -msse3 -fopenmp bitor.f
gfortran -c -Ofast -msse3 -fopenmp bndpot.f
gfortran -c -Ofast -msse3 -fopenmp bndstr.f
gfortran -c -Ofast -msse3 -fopenmp bound.f
gfortran -c -Ofast -msse3 -fopenmp boxes.f
gfortran -c -Ofast -msse3 -fopenmp cell.f
gfortran -c -Ofast -msse3 -fopenmp charge.f
gfortran -c -Ofast -msse3 -fopenmp chgpot.f
gfortran -c -Ofast -msse3 -fopenmp chrono.f
gfortran -c -Ofast -msse3 -fopenmp chunks.f
gfortran -c -Ofast -msse3 -fopenmp couple.f
gfortran -c -Ofast -msse3 -fopenmp deriv.f
gfortran -c -Ofast -msse3 -fopenmp dipole.f
gfortran -c -Ofast -msse3 -fopenmp disgeo.f
gfortran -c -Ofast -msse3 -fopenmp dma.f
gfortran -c -Ofast -msse3 -fopenmp domega.f
gfortran -c -Ofast -msse3 -fopenmp energi.f
gfortran -c -Ofast -msse3 -fopenmp ewald.f
gfortran -c -Ofast -msse3 -fopenmp faces.f
gfortran -c -Ofast -msse3 -fopenmp fft.f
gfortran -c -Ofast -msse3 -fopenmp fields.f
gfortran -c -Ofast -msse3 -fopenmp files.f
gfortran -c -Ofast -msse3 -fopenmp fracs.f
gfortran -c -Ofast -msse3 -fopenmp freeze.f
gfortran -c -Ofast -msse3 -fopenmp gkstuf.f
gfortran -c -Ofast -msse3 -fopenmp group.f
gfortran -c -Ofast -msse3 -fopenmp hescut.f
gfortran -c -Ofast -msse3 -fopenmp hessn.f
gfortran -c -Ofast -msse3 -fopenmp hpmf.f
gfortran -c -Ofast -msse3 -fopenmp ielscf.f
gfortran -c -Ofast -msse3 -fopenmp improp.f
gfortran -c -Ofast -msse3 -fopenmp imptor.f
gfortran -c -Ofast -msse3 -fopenmp inform.f
gfortran -c -Ofast -msse3 -fopenmp inter.f
gfortran -c -Ofast -msse3 -fopenmp iounit.f
gfortran -c -Ofast -msse3 -fopenmp kanang.f
gfortran -c -Ofast -msse3 -fopenmp kangs.f
gfortran -c -Ofast -msse3 -fopenmp kantor.f
gfortran -c -Ofast -msse3 -fopenmp katoms.f
gfortran -c -Ofast -msse3 -fopenmp kbonds.f
gfortran -c -Ofast -msse3 -fopenmp kchrge.f
gfortran -c -Ofast -msse3 -fopenmp kdipol.f
gfortran -c -Ofast -msse3 -fopenmp keys.f
gfortran -c -Ofast -msse3 -fopenmp khbond.f
gfortran -c -Ofast -msse3 -fopenmp kiprop.f
gfortran -c -Ofast -msse3 -fopenmp kitors.f
gfortran -c -Ofast -msse3 -fopenmp kmulti.f
gfortran -c -Ofast -msse3 -fopenmp kopbnd.f
gfortran -c -Ofast -msse3 -fopenmp kopdst.f
gfortran -c -Ofast -msse3 -fopenmp korbs.f
gfortran -c -Ofast -msse3 -fopenmp kpitor.f
gfortran -c -Ofast -msse3 -fopenmp kpolr.f
gfortran -c -Ofast -msse3 -fopenmp kstbnd.f
gfortran -c -Ofast -msse3 -fopenmp ksttor.f
gfortran -c -Ofast -msse3 -fopenmp ktorsn.f
gfortran -c -Ofast -msse3 -fopenmp ktrtor.f
gfortran -c -Ofast -msse3 -fopenmp kurybr.f
gfortran -c -Ofast -msse3 -fopenmp kvdwpr.f
gfortran -c -Ofast -msse3 -fopenmp kvdws.f
gfortran -c -Ofast -msse3 -fopenmp light.f
gfortran -c -Ofast -msse3 -fopenmp limits.f
gfortran -c -Ofast -msse3 -fopenmp linmin.f
gfortran -c -Ofast -msse3 -fopenmp math.f
gfortran -c -Ofast -msse3 -fopenmp mdstuf.f
gfortran -c -Ofast -msse3 -fopenmp merck.f
gfortran -c -Ofast -msse3 -fopenmp minima.f
gfortran -c -Ofast -msse3 -fopenmp molcul.f
gfortran -c -Ofast -msse3 -fopenmp moldyn.f
gfortran -c -Ofast -msse3 -fopenmp moment.f
gfortran -c -Ofast -msse3 -fopenmp mplpot.f
gfortran -c -Ofast -msse3 -fopenmp mpole.f
gfortran -c -Ofast -msse3 -fopenmp mrecip.f
gfortran -c -Ofast -msse3 -fopenmp mutant.f
gfortran -c -Ofast -msse3 -fopenmp neigh.f
gfortran -c -Ofast -msse3 -fopenmp nonpol.f
gfortran -c -Ofast -msse3 -fopenmp nucleo.f
gfortran -c -Ofast -msse3 -fopenmp omega.f
gfortran -c -Ofast -msse3 -fopenmp opbend.f
gfortran -c -Ofast -msse3 -fopenmp opdist.f
gfortran -c -Ofast -msse3 -fopenmp openmp.f
gfortran -c -Ofast -msse3 -fopenmp orbits.f
gfortran -c -Ofast -msse3 -fopenmp output.f
gfortran -c -Ofast -msse3 -fopenmp params.f
gfortran -c -Ofast -msse3 -fopenmp paths.f
gfortran -c -Ofast -msse3 -fopenmp pbstuf.f
gfortran -c -Ofast -msse3 -fopenmp pdb.f
gfortran -c -Ofast -msse3 -fopenmp phipsi.f
gfortran -c -Ofast -msse3 -fopenmp piorbs.f
gfortran -c -Ofast -msse3 -fopenmp pistuf.f
gfortran -c -Ofast -msse3 -fopenmp pitors.f
gfortran -c -Ofast -msse3 -fopenmp pme.f
gfortran -c -Ofast -msse3 -fopenmp polar.f
gfortran -c -Ofast -msse3 -fopenmp polgrp.f
gfortran -c -Ofast -msse3 -fopenmp polopt.f
gfortran -c -Ofast -msse3 -fopenmp polpot.f
gfortran -c -Ofast -msse3 -fopenmp poltcg.f
gfortran -c -Ofast -msse3 -fopenmp potent.f
gfortran -c -Ofast -msse3 -fopenmp potfit.f
gfortran -c -Ofast -msse3 -fopenmp precis.f
gfortran -c -Ofast -msse3 -fopenmp ptable.f
gfortran -c -Ofast -msse3 -fopenmp qmstuf.f
gfortran -c -Ofast -msse3 -fopenmp refer.f
gfortran -c -Ofast -msse3 -fopenmp resdue.f
gfortran -c -Ofast -msse3 -fopenmp restrn.f
gfortran -c -Ofast -msse3 -fopenmp rgddyn.f
gfortran -c -Ofast -msse3 -fopenmp rigid.f
gfortran -c -Ofast -msse3 -fopenmp ring.f
gfortran -c -Ofast -msse3 -fopenmp rotbnd.f
gfortran -c -Ofast -msse3 -fopenmp rxnfld.f
gfortran -c -Ofast -msse3 -fopenmp rxnpot.f
gfortran -c -Ofast -msse3 -fopenmp scales.f
gfortran -c -Ofast -msse3 -fopenmp sequen.f
gfortran -c -Ofast -msse3 -fopenmp shunt.f
gfortran -c -Ofast -msse3 -fopenmp socket.f
gfortran -c -Ofast -msse3 -fopenmp solute.f
gfortran -c -Ofast -msse3 -fopenmp stodyn.f
gfortran -c -Ofast -msse3 -fopenmp strbnd.f
gfortran -c -Ofast -msse3 -fopenmp strtor.f
gfortran -c -Ofast -msse3 -fopenmp syntrn.f
gfortran -c -Ofast -msse3 -fopenmp tarray.f
gfortran -c -Ofast -msse3 -fopenmp titles.f
gfortran -c -Ofast -msse3 -fopenmp torpot.f
gfortran -c -Ofast -msse3 -fopenmp tors.f
gfortran -c -Ofast -msse3 -fopenmp tortor.f
gfortran -c -Ofast -msse3 -fopenmp tree.f
gfortran -c -Ofast -msse3 -fopenmp units.f
gfortran -c -Ofast -msse3 -fopenmp uprior.f
gfortran -c -Ofast -msse3 -fopenmp urey.f
gfortran -c -Ofast -msse3 -fopenmp urypot.f
gfortran -c -Ofast -msse3 -fopenmp usage.f
gfortran -c -Ofast -msse3 -fopenmp usolve.f
gfortran -c -Ofast -msse3 -fopenmp valfit.f
gfortran -c -Ofast -msse3 -fopenmp vdw.f
gfortran -c -Ofast -msse3 -fopenmp vdwpot.f
gfortran -c -Ofast -msse3 -fopenmp vibs.f
gfortran -c -Ofast -msse3 -fopenmp virial.f
gfortran -c -Ofast -msse3 -fopenmp warp.f
gfortran -c -Ofast -msse3 -fopenmp xtals.f
gfortran -c -Ofast -msse3 -fopenmp zclose.f
gfortran -c -Ofast -msse3 -fopenmp zcoord.f
#
#  now compile separately each of the Fortran source files
#
gfortran -c -Ofast -msse3 -fopenmp active.f
gfortran -c -Ofast -msse3 -fopenmp alchemy.f
gfortran -c -Ofast -msse3 -fopenmp analysis.f
gfortran -c -Ofast -msse3 -fopenmp analyze.f
gfortran -c -Ofast -msse3 -fopenmp angles.f
gfortran -c -Ofast -msse3 -fopenmp anneal.f
gfortran -c -Ofast -msse3 -fopenmp archive.f
gfortran -c -Ofast -msse3 -fopenmp attach.f
gfortran -c -Ofast -msse3 -fopenmp baoab.f
gfortran -c -Ofast -msse3 -fopenmp bar.f
gfortran -c -Ofast -msse3 -fopenmp basefile.f
gfortran -c -Ofast -msse3 -fopenmp beeman.f
gfortran -c -Ofast -msse3 -fopenmp bicubic.f
gfortran -c -Ofast -msse3 -fopenmp bitors.f
gfortran -c -Ofast -msse3 -fopenmp bonds.f
gfortran -c -Ofast -msse3 -fopenmp born.f
gfortran -c -Ofast -msse3 -fopenmp bounds.f
gfortran -c -Ofast -msse3 -fopenmp bussi.f
gfortran -c -Ofast -msse3 -fopenmp calendar.f
gfortran -c -Ofast -msse3 -fopenmp center.f
gfortran -c -Ofast -msse3 -fopenmp chkpole.f
gfortran -c -Ofast -msse3 -fopenmp chkring.f
gfortran -c -Ofast -msse3 -fopenmp chkxyz.f
gfortran -c -Ofast -msse3 -fopenmp cholesky.f
gfortran -c -Ofast -msse3 -fopenmp clock.f
gfortran -c -Ofast -msse3 -fopenmp cluster.f
gfortran -c -Ofast -msse3 -fopenmp column.f
gfortran -c -Ofast -msse3 -fopenmp command.f
gfortran -c -Ofast -msse3 -fopenmp connect.f
gfortran -c -Ofast -msse3 -fopenmp connolly.f
gfortran -c -Ofast -msse3 -fopenmp control.f
gfortran -c -Ofast -msse3 -fopenmp correlate.f
gfortran -c -Ofast -msse3 -fopenmp crystal.f
gfortran -c -Ofast -msse3 -fopenmp cspline.f
gfortran -c -Ofast -msse3 -fopenmp cutoffs.f
gfortran -c -Ofast -msse3 -fopenmp deflate.f
gfortran -c -Ofast -msse3 -fopenmp delete.f
gfortran -c -Ofast -msse3 -fopenmp diagq.f
gfortran -c -Ofast -msse3 -fopenmp diffeq.f
gfortran -c -Ofast -msse3 -fopenmp diffuse.f
gfortran -c -Ofast -msse3 -fopenmp distgeom.f
gfortran -c -Ofast -msse3 -fopenmp document.f
gfortran -c -Ofast -msse3 -fopenmp dynamic.f
gfortran -c -Ofast -msse3 -fopenmp eangang.f
gfortran -c -Ofast -msse3 -fopenmp eangang1.f
gfortran -c -Ofast -msse3 -fopenmp eangang2.f
gfortran -c -Ofast -msse3 -fopenmp eangang3.f
gfortran -c -Ofast -msse3 -fopenmp eangle.f
gfortran -c -Ofast -msse3 -fopenmp eangle1.f
gfortran -c -Ofast -msse3 -fopenmp eangle2.f
gfortran -c -Ofast -msse3 -fopenmp eangle3.f
gfortran -c -Ofast -msse3 -fopenmp eangtor.f
gfortran -c -Ofast -msse3 -fopenmp eangtor1.f
gfortran -c -Ofast -msse3 -fopenmp eangtor2.f
gfortran -c -Ofast -msse3 -fopenmp eangtor3.f
gfortran -c -Ofast -msse3 -fopenmp ebond.f
gfortran -c -Ofast -msse3 -fopenmp ebond1.f
gfortran -c -Ofast -msse3 -fopenmp ebond2.f
gfortran -c -Ofast -msse3 -fopenmp ebond3.f
gfortran -c -Ofast -msse3 -fopenmp ebuck.f
gfortran -c -Ofast -msse3 -fopenmp ebuck1.f
gfortran -c -Ofast -msse3 -fopenmp ebuck2.f
gfortran -c -Ofast -msse3 -fopenmp ebuck3.f
gfortran -c -Ofast -msse3 -fopenmp echarge.f
gfortran -c -Ofast -msse3 -fopenmp echarge1.f
gfortran -c -Ofast -msse3 -fopenmp echarge2.f
gfortran -c -Ofast -msse3 -fopenmp echarge3.f
gfortran -c -Ofast -msse3 -fopenmp echgdpl.f
gfortran -c -Ofast -msse3 -fopenmp echgdpl1.f
gfortran -c -Ofast -msse3 -fopenmp echgdpl2.f
gfortran -c -Ofast -msse3 -fopenmp echgdpl3.f
gfortran -c -Ofast -msse3 -fopenmp edipole.f
gfortran -c -Ofast -msse3 -fopenmp edipole1.f
gfortran -c -Ofast -msse3 -fopenmp edipole2.f
gfortran -c -Ofast -msse3 -fopenmp edipole3.f
gfortran -c -Ofast -msse3 -fopenmp egauss.f
gfortran -c -Ofast -msse3 -fopenmp egauss1.f
gfortran -c -Ofast -msse3 -fopenmp egauss2.f
gfortran -c -Ofast -msse3 -fopenmp egauss3.f
gfortran -c -Ofast -msse3 -fopenmp egeom.f
gfortran -c -Ofast -msse3 -fopenmp egeom1.f
gfortran -c -Ofast -msse3 -fopenmp egeom2.f
gfortran -c -Ofast -msse3 -fopenmp egeom3.f
gfortran -c -Ofast -msse3 -fopenmp ehal.f
gfortran -c -Ofast -msse3 -fopenmp ehal1.f
gfortran -c -Ofast -msse3 -fopenmp ehal2.f
gfortran -c -Ofast -msse3 -fopenmp ehal3.f
gfortran -c -Ofast -msse3 -fopenmp eimprop.f
gfortran -c -Ofast -msse3 -fopenmp eimprop1.f
gfortran -c -Ofast -msse3 -fopenmp eimprop2.f
gfortran -c -Ofast -msse3 -fopenmp eimprop3.f
gfortran -c -Ofast -msse3 -fopenmp eimptor.f
gfortran -c -Ofast -msse3 -fopenmp eimptor1.f
gfortran -c -Ofast -msse3 -fopenmp eimptor2.f
gfortran -c -Ofast -msse3 -fopenmp eimptor3.f
gfortran -c -Ofast -msse3 -fopenmp elj.f
gfortran -c -Ofast -msse3 -fopenmp elj1.f
gfortran -c -Ofast -msse3 -fopenmp elj2.f
gfortran -c -Ofast -msse3 -fopenmp elj3.f
gfortran -c -Ofast -msse3 -fopenmp embed.f
gfortran -c -Ofast -msse3 -fopenmp emetal.f
gfortran -c -Ofast -msse3 -fopenmp emetal1.f
gfortran -c -Ofast -msse3 -fopenmp emetal2.f
gfortran -c -Ofast -msse3 -fopenmp emetal3.f
gfortran -c -Ofast -msse3 -fopenmp emm3hb.f
gfortran -c -Ofast -msse3 -fopenmp emm3hb1.f
gfortran -c -Ofast -msse3 -fopenmp emm3hb2.f
gfortran -c -Ofast -msse3 -fopenmp emm3hb3.f
gfortran -c -Ofast -msse3 -fopenmp empole.f
gfortran -c -Ofast -msse3 -fopenmp empole1.f
gfortran -c -Ofast -msse3 -fopenmp empole2.f
gfortran -c -Ofast -msse3 -fopenmp empole3.f
gfortran -c -Ofast -msse3 -fopenmp energy.f
gfortran -c -Ofast -msse3 -fopenmp eopbend.f
gfortran -c -Ofast -msse3 -fopenmp eopbend1.f
gfortran -c -Ofast -msse3 -fopenmp eopbend2.f
gfortran -c -Ofast -msse3 -fopenmp eopbend3.f
gfortran -c -Ofast -msse3 -fopenmp eopdist.f
gfortran -c -Ofast -msse3 -fopenmp eopdist1.f
gfortran -c -Ofast -msse3 -fopenmp eopdist2.f
gfortran -c -Ofast -msse3 -fopenmp eopdist3.f
gfortran -c -Ofast -msse3 -fopenmp epitors.f
gfortran -c -Ofast -msse3 -fopenmp epitors1.f
gfortran -c -Ofast -msse3 -fopenmp epitors2.f
gfortran -c -Ofast -msse3 -fopenmp epitors3.f
gfortran -c -Ofast -msse3 -fopenmp epolar.f
gfortran -c -Ofast -msse3 -fopenmp epolar1.f
gfortran -c -Ofast -msse3 -fopenmp epolar2.f
gfortran -c -Ofast -msse3 -fopenmp epolar3.f
gfortran -c -Ofast -msse3 -fopenmp erf.f
gfortran -c -Ofast -msse3 -fopenmp erxnfld.f
gfortran -c -Ofast -msse3 -fopenmp erxnfld1.f
gfortran -c -Ofast -msse3 -fopenmp erxnfld2.f
gfortran -c -Ofast -msse3 -fopenmp erxnfld3.f
gfortran -c -Ofast -msse3 -fopenmp esolv.f
gfortran -c -Ofast -msse3 -fopenmp esolv1.f
gfortran -c -Ofast -msse3 -fopenmp esolv2.f
gfortran -c -Ofast -msse3 -fopenmp esolv3.f
gfortran -c -Ofast -msse3 -fopenmp estrbnd.f
gfortran -c -Ofast -msse3 -fopenmp estrbnd1.f
gfortran -c -Ofast -msse3 -fopenmp estrbnd2.f
gfortran -c -Ofast -msse3 -fopenmp estrbnd3.f
gfortran -c -Ofast -msse3 -fopenmp estrtor.f
gfortran -c -Ofast -msse3 -fopenmp estrtor1.f
gfortran -c -Ofast -msse3 -fopenmp estrtor2.f
gfortran -c -Ofast -msse3 -fopenmp estrtor3.f
gfortran -c -Ofast -msse3 -fopenmp etors.f
gfortran -c -Ofast -msse3 -fopenmp etors1.f
gfortran -c -Ofast -msse3 -fopenmp etors2.f
gfortran -c -Ofast -msse3 -fopenmp etors3.f
gfortran -c -Ofast -msse3 -fopenmp etortor.f
gfortran -c -Ofast -msse3 -fopenmp etortor1.f
gfortran -c -Ofast -msse3 -fopenmp etortor2.f
gfortran -c -Ofast -msse3 -fopenmp etortor3.f
gfortran -c -Ofast -msse3 -fopenmp eurey.f
gfortran -c -Ofast -msse3 -fopenmp eurey1.f
gfortran -c -Ofast -msse3 -fopenmp eurey2.f
gfortran -c -Ofast -msse3 -fopenmp eurey3.f
gfortran -c -Ofast -msse3 -fopenmp evcorr.f
gfortran -c -Ofast -msse3 -fopenmp extra.f
gfortran -c -Ofast -msse3 -fopenmp extra1.f
gfortran -c -Ofast -msse3 -fopenmp extra2.f
gfortran -c -Ofast -msse3 -fopenmp extra3.f
gfortran -c -Ofast -msse3 -fopenmp fatal.f
gfortran -c -Ofast -msse3 -fopenmp fft3d.f
gfortran -c -Ofast -msse3 -fopenmp fftpack.f
gfortran -c -Ofast -msse3 -fopenmp field.f
gfortran -c -Ofast -msse3 -fopenmp final.f
gfortran -c -Ofast -msse3 -fopenmp flatten.f
gfortran -c -Ofast -msse3 -fopenmp freeunit.f
gfortran -c -Ofast -msse3 -fopenmp gda.f
gfortran -c -Ofast -msse3 -fopenmp geometry.f
gfortran -c -Ofast -msse3 -fopenmp getarc.f
gfortran -c -Ofast -msse3 -fopenmp getint.f
gfortran -c -Ofast -msse3 -fopenmp getkey.f
gfortran -c -Ofast -msse3 -fopenmp getmol.f
gfortran -c -Ofast -msse3 -fopenmp getmol2.f
gfortran -c -Ofast -msse3 -fopenmp getnumb.f
gfortran -c -Ofast -msse3 -fopenmp getpdb.f
gfortran -c -Ofast -msse3 -fopenmp getprm.f
gfortran -c -Ofast -msse3 -fopenmp getref.f
gfortran -c -Ofast -msse3 -fopenmp getstring.f
gfortran -c -Ofast -msse3 -fopenmp gettext.f
gfortran -c -Ofast -msse3 -fopenmp getword.f
gfortran -c -Ofast -msse3 -fopenmp getxyz.f
gfortran -c -Ofast -msse3 -fopenmp ghmcstep.f
gfortran -c -Ofast -msse3 -fopenmp gradient.f
gfortran -c -Ofast -msse3 -fopenmp gradrgd.f
gfortran -c -Ofast -msse3 -fopenmp gradrot.f
gfortran -c -Ofast -msse3 -fopenmp groups.f
gfortran -c -Ofast -msse3 -fopenmp grpline.f
gfortran -c -Ofast -msse3 -fopenmp gyrate.f
gfortran -c -Ofast -msse3 -fopenmp hessian.f
gfortran -c -Ofast -msse3 -fopenmp hessrgd.f
gfortran -c -Ofast -msse3 -fopenmp hessrot.f
gfortran -c -Ofast -msse3 -fopenmp hybrid.f
gfortran -c -Ofast -msse3 -fopenmp image.f
gfortran -c -Ofast -msse3 -fopenmp impose.f
gfortran -c -Ofast -msse3 -fopenmp induce.f
gfortran -c -Ofast -msse3 -fopenmp inertia.f
gfortran -c -Ofast -msse3 -fopenmp initatom.f
gfortran -c -Ofast -msse3 -fopenmp initial.f
gfortran -c -Ofast -msse3 -fopenmp initprm.f
gfortran -c -Ofast -msse3 -fopenmp initres.f
gfortran -c -Ofast -msse3 -fopenmp initrot.f
gfortran -c -Ofast -msse3 -fopenmp insert.f
gfortran -c -Ofast -msse3 -fopenmp intedit.f
gfortran -c -Ofast -msse3 -fopenmp intxyz.f
gfortran -c -Ofast -msse3 -fopenmp invbeta.f
gfortran -c -Ofast -msse3 -fopenmp invert.f
gfortran -c -Ofast -msse3 -fopenmp jacobi.f
gfortran -c -Ofast -msse3 -fopenmp kangang.f
gfortran -c -Ofast -msse3 -fopenmp kangle.f
gfortran -c -Ofast -msse3 -fopenmp kangtor.f
gfortran -c -Ofast -msse3 -fopenmp katom.f
gfortran -c -Ofast -msse3 -fopenmp kbond.f
gfortran -c -Ofast -msse3 -fopenmp kcharge.f
gfortran -c -Ofast -msse3 -fopenmp kdipole.f
gfortran -c -Ofast -msse3 -fopenmp kewald.f
gfortran -c -Ofast -msse3 -fopenmp kextra.f
gfortran -c -Ofast -msse3 -fopenmp kgeom.f
gfortran -c -Ofast -msse3 -fopenmp kimprop.f
gfortran -c -Ofast -msse3 -fopenmp kimptor.f
gfortran -c -Ofast -msse3 -fopenmp kinetic.f
gfortran -c -Ofast -msse3 -fopenmp kmetal.f
gfortran -c -Ofast -msse3 -fopenmp kmpole.f
gfortran -c -Ofast -msse3 -fopenmp kopbend.f
gfortran -c -Ofast -msse3 -fopenmp kopdist.f
gfortran -c -Ofast -msse3 -fopenmp korbit.f
gfortran -c -Ofast -msse3 -fopenmp kpitors.f
gfortran -c -Ofast -msse3 -fopenmp kpolar.f
gfortran -c -Ofast -msse3 -fopenmp ksolv.f
gfortran -c -Ofast -msse3 -fopenmp kstrbnd.f
gfortran -c -Ofast -msse3 -fopenmp kstrtor.f
gfortran -c -Ofast -msse3 -fopenmp ktors.f
gfortran -c -Ofast -msse3 -fopenmp ktortor.f
gfortran -c -Ofast -msse3 -fopenmp kurey.f
gfortran -c -Ofast -msse3 -fopenmp kvdw.f
gfortran -c -Ofast -msse3 -fopenmp lattice.f
gfortran -c -Ofast -msse3 -fopenmp lbfgs.f
gfortran -c -Ofast -msse3 -fopenmp lights.f
gfortran -c -Ofast -msse3 -fopenmp makeint.f
gfortran -c -Ofast -msse3 -fopenmp makeref.f
gfortran -c -Ofast -msse3 -fopenmp makexyz.f
gfortran -c -Ofast -msse3 -fopenmp maxwell.f
gfortran -c -Ofast -msse3 -fopenmp mdinit.f
gfortran -c -Ofast -msse3 -fopenmp mdrest.f
gfortran -c -Ofast -msse3 -fopenmp mdsave.f
gfortran -c -Ofast -msse3 -fopenmp mdstat.f
gfortran -c -Ofast -msse3 -fopenmp mechanic.f
gfortran -c -Ofast -msse3 -fopenmp merge.f
gfortran -c -Ofast -msse3 -fopenmp minimize.f
gfortran -c -Ofast -msse3 -fopenmp minirot.f
gfortran -c -Ofast -msse3 -fopenmp minrigid.f
gfortran -c -Ofast -msse3 -fopenmp mol2xyz.f
gfortran -c -Ofast -msse3 -fopenmp molecule.f
gfortran -c -Ofast -msse3 -fopenmp molxyz.f
gfortran -c -Ofast -msse3 -fopenmp moments.f
gfortran -c -Ofast -msse3 -fopenmp monte.f
gfortran -c -Ofast -msse3 -fopenmp mutate.f
gfortran -c -Ofast -msse3 -fopenmp nblist.f
gfortran -c -Ofast -msse3 -fopenmp newton.f
gfortran -c -Ofast -msse3 -fopenmp newtrot.f
gfortran -c -Ofast -msse3 -fopenmp nextarg.f
gfortran -c -Ofast -msse3 -fopenmp nexttext.f
gfortran -c -Ofast -msse3 -fopenmp nose.f
gfortran -c -Ofast -msse3 -fopenmp nspline.f
gfortran -c -Ofast -msse3 -fopenmp nucleic.f
gfortran -c -Ofast -msse3 -fopenmp number.f
gfortran -c -Ofast -msse3 -fopenmp numeral.f
gfortran -c -Ofast -msse3 -fopenmp numgrad.f
gfortran -c -Ofast -msse3 -fopenmp ocvm.f
gfortran -c -Ofast -msse3 -fopenmp openend.f
gfortran -c -Ofast -msse3 -fopenmp optimize.f
gfortran -c -Ofast -msse3 -fopenmp optirot.f
gfortran -c -Ofast -msse3 -fopenmp optrigid.f
gfortran -c -Ofast -msse3 -fopenmp optsave.f
gfortran -c -Ofast -msse3 -fopenmp orbital.f
gfortran -c -Ofast -msse3 -fopenmp orient.f
gfortran -c -Ofast -msse3 -fopenmp orthog.f
gfortran -c -Ofast -msse3 -fopenmp overlap.f
gfortran -c -Ofast -msse3 -fopenmp path.f
gfortran -c -Ofast -msse3 -fopenmp pdbxyz.f
gfortran -c -Ofast -msse3 -fopenmp picalc.f
gfortran -c -Ofast -msse3 -fopenmp pmestuf.f
gfortran -c -Ofast -msse3 -fopenmp pmpb.f
gfortran -c -Ofast -msse3 -fopenmp polarize.f
gfortran -c -Ofast -msse3 -fopenmp poledit.f
gfortran -c -Ofast -msse3 -fopenmp polymer.f
gfortran -c -Ofast -msse3 -fopenmp potential.f
gfortran -c -Ofast -msse3 -fopenmp precise.f
gfortran -c -Ofast -msse3 -fopenmp pressure.f
gfortran -c -Ofast -msse3 -fopenmp prmedit.f
gfortran -c -Ofast -msse3 -fopenmp prmkey.f
gfortran -c -Ofast -msse3 -fopenmp promo.f
gfortran -c -Ofast -msse3 -fopenmp protein.f
gfortran -c -Ofast -msse3 -fopenmp prtdyn.f
gfortran -c -Ofast -msse3 -fopenmp prterr.f
gfortran -c -Ofast -msse3 -fopenmp prtint.f
gfortran -c -Ofast -msse3 -fopenmp prtmol2.f
gfortran -c -Ofast -msse3 -fopenmp prtpdb.f
gfortran -c -Ofast -msse3 -fopenmp prtprm.f
gfortran -c -Ofast -msse3 -fopenmp prtseq.f
gfortran -c -Ofast -msse3 -fopenmp prtxyz.f
gfortran -c -Ofast -msse3 -fopenmp pss.f
gfortran -c -Ofast -msse3 -fopenmp pssrigid.f
gfortran -c -Ofast -msse3 -fopenmp pssrot.f
gfortran -c -Ofast -msse3 -fopenmp qrfact.f
gfortran -c -Ofast -msse3 -fopenmp quatfit.f
gfortran -c -Ofast -msse3 -fopenmp radial.f
gfortran -c -Ofast -msse3 -fopenmp random.f
gfortran -c -Ofast -msse3 -fopenmp rattle.f
gfortran -c -Ofast -msse3 -fopenmp readdyn.f
gfortran -c -Ofast -msse3 -fopenmp readgau.f
gfortran -c -Ofast -msse3 -fopenmp readgdma.f
gfortran -c -Ofast -msse3 -fopenmp readint.f
gfortran -c -Ofast -msse3 -fopenmp readmol.f
gfortran -c -Ofast -msse3 -fopenmp readmol2.f
gfortran -c -Ofast -msse3 -fopenmp readpdb.f
gfortran -c -Ofast -msse3 -fopenmp readprm.f
gfortran -c -Ofast -msse3 -fopenmp readseq.f
gfortran -c -Ofast -msse3 -fopenmp readxyz.f
gfortran -c -Ofast -msse3 -fopenmp replica.f
gfortran -c -Ofast -msse3 -fopenmp respa.f
gfortran -c -Ofast -msse3 -fopenmp rgdstep.f
gfortran -c -Ofast -msse3 -fopenmp rings.f
gfortran -c -Ofast -msse3 -fopenmp rmsfit.f
gfortran -c -Ofast -msse3 -fopenmp rotlist.f
gfortran -c -Ofast -msse3 -fopenmp rotpole.f
gfortran -c -Ofast -msse3 -fopenmp saddle.f
gfortran -c -Ofast -msse3 -fopenmp scan.f
gfortran -c -Ofast -msse3 -fopenmp sdstep.f
gfortran -c -Ofast -msse3 -fopenmp search.f
gfortran -c -Ofast -msse3 -fopenmp server.f
gfortran -c -Ofast -msse3 -fopenmp shakeup.f
gfortran -c -Ofast -msse3 -fopenmp sigmoid.f
gfortran -c -Ofast -msse3 -fopenmp simplex.f
gfortran -c -Ofast -msse3 -fopenmp sktstuf.f
gfortran -c -Ofast -msse3 -fopenmp sniffer.f
gfortran -c -Ofast -msse3 -fopenmp sort.f
gfortran -c -Ofast -msse3 -fopenmp spacefill.f
gfortran -c -Ofast -msse3 -fopenmp spectrum.f
gfortran -c -Ofast -msse3 -fopenmp square.f
gfortran -c -Ofast -msse3 -fopenmp suffix.f
gfortran -c -Ofast -msse3 -fopenmp superpose.f
gfortran -c -Ofast -msse3 -fopenmp surface.f
gfortran -c -Ofast -msse3 -fopenmp surfatom.f
gfortran -c -Ofast -msse3 -fopenmp switch.f
gfortran -c -Ofast -msse3 -fopenmp tcgstuf.f
gfortran -c -Ofast -msse3 -fopenmp temper.f
gfortran -c -Ofast -msse3 -fopenmp testgrad.f
gfortran -c -Ofast -msse3 -fopenmp testhess.f
gfortran -c -Ofast -msse3 -fopenmp testpair.f
gfortran -c -Ofast -msse3 -fopenmp testpol.f
gfortran -c -Ofast -msse3 -fopenmp testrot.f
gfortran -c -Ofast -msse3 -fopenmp testvir.f
gfortran -c -Ofast -msse3 -fopenmp timer.f
gfortran -c -Ofast -msse3 -fopenmp timerot.f
gfortran -c -Ofast -msse3 -fopenmp tncg.f
gfortran -c -Ofast -msse3 -fopenmp torphase.f
gfortran -c -Ofast -msse3 -fopenmp torque.f
gfortran -c -Ofast -msse3 -fopenmp torsfit.f
gfortran -c -Ofast -msse3 -fopenmp torsions.f
gfortran -c -Ofast -msse3 -fopenmp trimtext.f
gfortran -c -Ofast -msse3 -fopenmp unitcell.f
gfortran -c -Ofast -msse3 -fopenmp valence.f
gfortran -c -Ofast -msse3 -fopenmp verlet.f
gfortran -c -Ofast -msse3 -fopenmp version.f
gfortran -c -Ofast -msse3 -fopenmp vibbig.f
gfortran -c -Ofast -msse3 -fopenmp vibrate.f
gfortran -c -Ofast -msse3 -fopenmp vibrot.f
gfortran -c -Ofast -msse3 -fopenmp volume.f
gfortran -c -Ofast -msse3 -fopenmp xtalfit.f
gfortran -c -Ofast -msse3 -fopenmp xtalmin.f
gfortran -c -Ofast -msse3 -fopenmp xyzatm.f
gfortran -c -Ofast -msse3 -fopenmp xyzedit.f
gfortran -c -Ofast -msse3 -fopenmp xyzint.f
gfortran -c -Ofast -msse3 -fopenmp xyzmol2.f
gfortran -c -Ofast -msse3 -fopenmp xyzpdb.f
gfortran -c -Ofast -msse3 -fopenmp zatom.f
