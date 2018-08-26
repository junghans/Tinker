#
#
#  #################################################################
#  ##                                                             ##
#  ##  debug.make  --  compile the Tinker routines for debugging  ##
#  ##              (Intel Fortran for Linux Version)              ##
#  ##                                                             ##
#  #################################################################
#
#
#  compile all the modules; "sizes" must be first since it is used
#  to set static array dimensions in many of the other modules
#
#
ifort -c -g -warn all -check all sizes.f
ifort -c -g -warn all -check all action.f
ifort -c -g -warn all -check all align.f
ifort -c -g -warn all -check all analyz.f
ifort -c -g -warn all -check all angang.f
ifort -c -g -warn all -check all angbnd.f
ifort -c -g -warn all -check all angpot.f
ifort -c -g -warn all -check all angtor.f
ifort -c -g -warn all -check all argue.f
ifort -c -g -warn all -check all ascii.f
ifort -c -g -warn all -check all atmlst.f
ifort -c -g -warn all -check all atomid.f
ifort -c -g -warn all -check all atoms.f
ifort -c -g -warn all -check all bath.f
ifort -c -g -warn all -check all bitor.f
ifort -c -g -warn all -check all bndpot.f
ifort -c -g -warn all -check all bndstr.f
ifort -c -g -warn all -check all bound.f
ifort -c -g -warn all -check all boxes.f
ifort -c -g -warn all -check all cell.f
ifort -c -g -warn all -check all charge.f
ifort -c -g -warn all -check all chgpot.f
ifort -c -g -warn all -check all chrono.f
ifort -c -g -warn all -check all chunks.f
ifort -c -g -warn all -check all couple.f
ifort -c -g -warn all -check all deriv.f
ifort -c -g -warn all -check all dipole.f
ifort -c -g -warn all -check all disgeo.f
ifort -c -g -warn all -check all dma.f
ifort -c -g -warn all -check all domega.f
ifort -c -g -warn all -check all energi.f
ifort -c -g -warn all -check all ewald.f
ifort -c -g -warn all -check all faces.f
ifort -c -g -warn all -check all fft.f
ifort -c -g -warn all -check all fields.f
ifort -c -g -warn all -check all files.f
ifort -c -g -warn all -check all fracs.f
ifort -c -g -warn all -check all freeze.f
ifort -c -g -warn all -check all gkstuf.f
ifort -c -g -warn all -check all group.f
ifort -c -g -warn all -check all hescut.f
ifort -c -g -warn all -check all hessn.f
ifort -c -g -warn all -check all hpmf.f
ifort -c -g -warn all -check all ielscf.f
ifort -c -g -warn all -check all improp.f
ifort -c -g -warn all -check all imptor.f
ifort -c -g -warn all -check all inform.f
ifort -c -g -warn all -check all inter.f
ifort -c -g -warn all -check all iounit.f
ifort -c -g -warn all -check all kanang.f
ifort -c -g -warn all -check all kangs.f
ifort -c -g -warn all -check all kantor.f
ifort -c -g -warn all -check all katoms.f
ifort -c -g -warn all -check all kbonds.f
ifort -c -g -warn all -check all kchrge.f
ifort -c -g -warn all -check all kdipol.f
ifort -c -g -warn all -check all keys.f
ifort -c -g -warn all -check all khbond.f
ifort -c -g -warn all -check all kiprop.f
ifort -c -g -warn all -check all kitors.f
ifort -c -g -warn all -check all kmulti.f
ifort -c -g -warn all -check all kopbnd.f
ifort -c -g -warn all -check all kopdst.f
ifort -c -g -warn all -check all korbs.f
ifort -c -g -warn all -check all kpitor.f
ifort -c -g -warn all -check all kpolr.f
ifort -c -g -warn all -check all kstbnd.f
ifort -c -g -warn all -check all ksttor.f
ifort -c -g -warn all -check all ktorsn.f
ifort -c -g -warn all -check all ktrtor.f
ifort -c -g -warn all -check all kurybr.f
ifort -c -g -warn all -check all kvdwpr.f
ifort -c -g -warn all -check all kvdws.f
ifort -c -g -warn all -check all light.f
ifort -c -g -warn all -check all limits.f
ifort -c -g -warn all -check all linmin.f
ifort -c -g -warn all -check all math.f
ifort -c -g -warn all -check all mdstuf.f
ifort -c -g -warn all -check all merck.f
ifort -c -g -warn all -check all minima.f
ifort -c -g -warn all -check all molcul.f
ifort -c -g -warn all -check all moldyn.f
ifort -c -g -warn all -check all moment.f
ifort -c -g -warn all -check all mplpot.f
ifort -c -g -warn all -check all mpole.f
ifort -c -g -warn all -check all mrecip.f
ifort -c -g -warn all -check all mutant.f
ifort -c -g -warn all -check all neigh.f
ifort -c -g -warn all -check all nonpol.f
ifort -c -g -warn all -check all nucleo.f
ifort -c -g -warn all -check all omega.f
ifort -c -g -warn all -check all opbend.f
ifort -c -g -warn all -check all opdist.f
ifort -c -g -warn all -check all openmp.f
ifort -c -g -warn all -check all orbits.f
ifort -c -g -warn all -check all output.f
ifort -c -g -warn all -check all params.f
ifort -c -g -warn all -check all paths.f
ifort -c -g -warn all -check all pbstuf.f
ifort -c -g -warn all -check all pdb.f
ifort -c -g -warn all -check all phipsi.f
ifort -c -g -warn all -check all piorbs.f
ifort -c -g -warn all -check all pistuf.f
ifort -c -g -warn all -check all pitors.f
ifort -c -g -warn all -check all pme.f
ifort -c -g -warn all -check all polar.f
ifort -c -g -warn all -check all polgrp.f
ifort -c -g -warn all -check all polopt.f
ifort -c -g -warn all -check all polpot.f
ifort -c -g -warn all -check all poltcg.f
ifort -c -g -warn all -check all potent.f
ifort -c -g -warn all -check all potfit.f
ifort -c -g -warn all -check all precis.f
ifort -c -g -warn all -check all ptable.f
ifort -c -g -warn all -check all qmstuf.f
ifort -c -g -warn all -check all refer.f
ifort -c -g -warn all -check all resdue.f
ifort -c -g -warn all -check all restrn.f
ifort -c -g -warn all -check all rgddyn.f
ifort -c -g -warn all -check all rigid.f
ifort -c -g -warn all -check all ring.f
ifort -c -g -warn all -check all rotbnd.f
ifort -c -g -warn all -check all rxnfld.f
ifort -c -g -warn all -check all rxnpot.f
ifort -c -g -warn all -check all scales.f
ifort -c -g -warn all -check all sequen.f
ifort -c -g -warn all -check all shunt.f
ifort -c -g -warn all -check all socket.f
ifort -c -g -warn all -check all solute.f
ifort -c -g -warn all -check all stodyn.f
ifort -c -g -warn all -check all strbnd.f
ifort -c -g -warn all -check all strtor.f
ifort -c -g -warn all -check all syntrn.f
ifort -c -g -warn all -check all tarray.f
ifort -c -g -warn all -check all titles.f
ifort -c -g -warn all -check all torpot.f
ifort -c -g -warn all -check all tors.f
ifort -c -g -warn all -check all tortor.f
ifort -c -g -warn all -check all tree.f
ifort -c -g -warn all -check all units.f
ifort -c -g -warn all -check all uprior.f
ifort -c -g -warn all -check all urey.f
ifort -c -g -warn all -check all urypot.f
ifort -c -g -warn all -check all usage.f
ifort -c -g -warn all -check all usolve.f
ifort -c -g -warn all -check all valfit.f
ifort -c -g -warn all -check all vdw.f
ifort -c -g -warn all -check all vdwpot.f
ifort -c -g -warn all -check all vibs.f
ifort -c -g -warn all -check all virial.f
ifort -c -g -warn all -check all warp.f
ifort -c -g -warn all -check all xtals.f
ifort -c -g -warn all -check all zclose.f
ifort -c -g -warn all -check all zcoord.f
#
#  now compile separately each of the Fortran source files
#
ifort -c -g -warn all -check all active.f
ifort -c -g -warn all -check all alchemy.f
ifort -c -g -warn all -check all analysis.f
ifort -c -g -warn all -check all analyze.f
ifort -c -g -warn all -check all angles.f
ifort -c -g -warn all -check all anneal.f
ifort -c -g -warn all -check all archive.f
ifort -c -g -warn all -check all attach.f
ifort -c -g -warn all -check all baoab.f
ifort -c -g -warn all -check all bar.f
ifort -c -g -warn all -check all basefile.f
ifort -c -g -warn all -check all beeman.f
ifort -c -g -warn all -check all bicubic.f
ifort -c -g -warn all -check all bitors.f
ifort -c -g -warn all -check all bonds.f
ifort -c -g -warn all -check all born.f
ifort -c -g -warn all -check all bounds.f
ifort -c -g -warn all -check all bussi.f
ifort -c -g -warn all -check all calendar.f
ifort -c -g -warn all -check all center.f
ifort -c -g -warn all -check all chkpole.f
ifort -c -g -warn all -check all chkring.f
ifort -c -g -warn all -check all chkxyz.f
ifort -c -g -warn all -check all cholesky.f
ifort -c -g -warn all -check all clock.f
ifort -c -g -warn all -check all cluster.f
ifort -c -g -warn all -check all column.f
ifort -c -g -warn all -check all command.f
ifort -c -g -warn all -check all connect.f
ifort -c -g -warn all -check all connolly.f
ifort -c -g -warn all -check all control.f
ifort -c -g -warn all -check all correlate.f
ifort -c -g -warn all -check all crystal.f
ifort -c -g -warn all -check all cspline.f
ifort -c -g -warn all -check all cutoffs.f
ifort -c -g -warn all -check all deflate.f
ifort -c -g -warn all -check all delete.f
ifort -c -g -warn all -check all diagq.f
ifort -c -g -warn all -check all diffeq.f
ifort -c -g -warn all -check all diffuse.f
ifort -c -g -warn all -check all distgeom.f
ifort -c -g -warn all -check all document.f
ifort -c -g -warn all -check all dynamic.f
ifort -c -g -warn all -check all eangang.f
ifort -c -g -warn all -check all eangang1.f
ifort -c -g -warn all -check all eangang2.f
ifort -c -g -warn all -check all eangang3.f
ifort -c -g -warn all -check all eangle.f
ifort -c -g -warn all -check all eangle1.f
ifort -c -g -warn all -check all eangle2.f
ifort -c -g -warn all -check all eangle3.f
ifort -c -g -warn all -check all eangtor.f
ifort -c -g -warn all -check all eangtor1.f
ifort -c -g -warn all -check all eangtor2.f
ifort -c -g -warn all -check all eangtor3.f
ifort -c -g -warn all -check all ebond.f
ifort -c -g -warn all -check all ebond1.f
ifort -c -g -warn all -check all ebond2.f
ifort -c -g -warn all -check all ebond3.f
ifort -c -g -warn all -check all ebuck.f
ifort -c -g -warn all -check all ebuck1.f
ifort -c -g -warn all -check all ebuck2.f
ifort -c -g -warn all -check all ebuck3.f
ifort -c -g -warn all -check all echarge.f
ifort -c -g -warn all -check all echarge1.f
ifort -c -g -warn all -check all echarge2.f
ifort -c -g -warn all -check all echarge3.f
ifort -c -g -warn all -check all echgdpl.f
ifort -c -g -warn all -check all echgdpl1.f
ifort -c -g -warn all -check all echgdpl2.f
ifort -c -g -warn all -check all echgdpl3.f
ifort -c -g -warn all -check all edipole.f
ifort -c -g -warn all -check all edipole1.f
ifort -c -g -warn all -check all edipole2.f
ifort -c -g -warn all -check all edipole3.f
ifort -c -g -warn all -check all egauss.f
ifort -c -g -warn all -check all egauss1.f
ifort -c -g -warn all -check all egauss2.f
ifort -c -g -warn all -check all egauss3.f
ifort -c -g -warn all -check all egeom.f
ifort -c -g -warn all -check all egeom1.f
ifort -c -g -warn all -check all egeom2.f
ifort -c -g -warn all -check all egeom3.f
ifort -c -g -warn all -check all ehal.f
ifort -c -g -warn all -check all ehal1.f
ifort -c -g -warn all -check all ehal2.f
ifort -c -g -warn all -check all ehal3.f
ifort -c -g -warn all -check all eimprop.f
ifort -c -g -warn all -check all eimprop1.f
ifort -c -g -warn all -check all eimprop2.f
ifort -c -g -warn all -check all eimprop3.f
ifort -c -g -warn all -check all eimptor.f
ifort -c -g -warn all -check all eimptor1.f
ifort -c -g -warn all -check all eimptor2.f
ifort -c -g -warn all -check all eimptor3.f
ifort -c -g -warn all -check all elj.f
ifort -c -g -warn all -check all elj1.f
ifort -c -g -warn all -check all elj2.f
ifort -c -g -warn all -check all elj3.f
ifort -c -g -warn all -check all embed.f
ifort -c -g -warn all -check all emetal.f
ifort -c -g -warn all -check all emetal1.f
ifort -c -g -warn all -check all emetal2.f
ifort -c -g -warn all -check all emetal3.f
ifort -c -g -warn all -check all emm3hb.f
ifort -c -g -warn all -check all emm3hb1.f
ifort -c -g -warn all -check all emm3hb2.f
ifort -c -g -warn all -check all emm3hb3.f
ifort -c -g -warn all -check all empole.f
ifort -c -g -warn all -check all empole1.f
ifort -c -g -warn all -check all empole2.f
ifort -c -g -warn all -check all empole3.f
ifort -c -g -warn all -check all energy.f
ifort -c -g -warn all -check all eopbend.f
ifort -c -g -warn all -check all eopbend1.f
ifort -c -g -warn all -check all eopbend2.f
ifort -c -g -warn all -check all eopbend3.f
ifort -c -g -warn all -check all eopdist.f
ifort -c -g -warn all -check all eopdist1.f
ifort -c -g -warn all -check all eopdist2.f
ifort -c -g -warn all -check all eopdist3.f
ifort -c -g -warn all -check all epitors.f
ifort -c -g -warn all -check all epitors1.f
ifort -c -g -warn all -check all epitors2.f
ifort -c -g -warn all -check all epitors3.f
ifort -c -g -warn all -check all epolar.f
ifort -c -g -warn all -check all epolar1.f
ifort -c -g -warn all -check all epolar2.f
ifort -c -g -warn all -check all epolar3.f
ifort -c -g -warn all -check all erf.f
ifort -c -g -warn all -check all erxnfld.f
ifort -c -g -warn all -check all erxnfld1.f
ifort -c -g -warn all -check all erxnfld2.f
ifort -c -g -warn all -check all erxnfld3.f
ifort -c -g -warn all -check all esolv.f
ifort -c -g -warn all -check all esolv1.f
ifort -c -g -warn all -check all esolv2.f
ifort -c -g -warn all -check all esolv3.f
ifort -c -g -warn all -check all estrbnd.f
ifort -c -g -warn all -check all estrbnd1.f
ifort -c -g -warn all -check all estrbnd2.f
ifort -c -g -warn all -check all estrbnd3.f
ifort -c -g -warn all -check all estrtor.f
ifort -c -g -warn all -check all estrtor1.f
ifort -c -g -warn all -check all estrtor2.f
ifort -c -g -warn all -check all estrtor3.f
ifort -c -g -warn all -check all etors.f
ifort -c -g -warn all -check all etors1.f
ifort -c -g -warn all -check all etors2.f
ifort -c -g -warn all -check all etors3.f
ifort -c -g -warn all -check all etortor.f
ifort -c -g -warn all -check all etortor1.f
ifort -c -g -warn all -check all etortor2.f
ifort -c -g -warn all -check all etortor3.f
ifort -c -g -warn all -check all eurey.f
ifort -c -g -warn all -check all eurey1.f
ifort -c -g -warn all -check all eurey2.f
ifort -c -g -warn all -check all eurey3.f
ifort -c -g -warn all -check all evcorr.f
ifort -c -g -warn all -check all extra.f
ifort -c -g -warn all -check all extra1.f
ifort -c -g -warn all -check all extra2.f
ifort -c -g -warn all -check all extra3.f
ifort -c -g -warn all -check all fatal.f
ifort -c -g -warn all -check all fft3d.f
ifort -c -g -warn all -check all fftpack.f
ifort -c -g -warn all -check all field.f
ifort -c -g -warn all -check all final.f
ifort -c -g -warn all -check all flatten.f
ifort -c -g -warn all -check all freeunit.f
ifort -c -g -warn all -check all gda.f
ifort -c -g -warn all -check all geometry.f
ifort -c -g -warn all -check all getarc.f
ifort -c -g -warn all -check all getint.f
ifort -c -g -warn all -check all getkey.f
ifort -c -g -warn all -check all getmol.f
ifort -c -g -warn all -check all getmol2.f
ifort -c -g -warn all -check all getnumb.f
ifort -c -g -warn all -check all getpdb.f
ifort -c -g -warn all -check all getprm.f
ifort -c -g -warn all -check all getref.f
ifort -c -g -warn all -check all getstring.f
ifort -c -g -warn all -check all gettext.f
ifort -c -g -warn all -check all getword.f
ifort -c -g -warn all -check all getxyz.f
ifort -c -g -warn all -check all ghmcstep.f
ifort -c -g -warn all -check all gradient.f
ifort -c -g -warn all -check all gradrgd.f
ifort -c -g -warn all -check all gradrot.f
ifort -c -g -warn all -check all groups.f
ifort -c -g -warn all -check all grpline.f
ifort -c -g -warn all -check all gyrate.f
ifort -c -g -warn all -check all hessian.f
ifort -c -g -warn all -check all hessrgd.f
ifort -c -g -warn all -check all hessrot.f
ifort -c -g -warn all -check all hybrid.f
ifort -c -g -warn all -check all image.f
ifort -c -g -warn all -check all impose.f
ifort -c -g -warn all -check all induce.f
ifort -c -g -warn all -check all inertia.f
ifort -c -g -warn all -check all initatom.f
ifort -c -g -warn all -check all initial.f
ifort -c -g -warn all -check all initprm.f
ifort -c -g -warn all -check all initres.f
ifort -c -g -warn all -check all initrot.f
ifort -c -g -warn all -check all insert.f
ifort -c -g -warn all -check all intedit.f
ifort -c -g -warn all -check all intxyz.f
ifort -c -g -warn all -check all invbeta.f
ifort -c -g -warn all -check all invert.f
ifort -c -g -warn all -check all jacobi.f
ifort -c -g -warn all -check all kangang.f
ifort -c -g -warn all -check all kangle.f
ifort -c -g -warn all -check all kangtor.f
ifort -c -g -warn all -check all katom.f
ifort -c -g -warn all -check all kbond.f
ifort -c -g -warn all -check all kcharge.f
ifort -c -g -warn all -check all kdipole.f
ifort -c -g -warn all -check all kewald.f
ifort -c -g -warn all -check all kextra.f
ifort -c -g -warn all -check all kgeom.f
ifort -c -g -warn all -check all kimprop.f
ifort -c -g -warn all -check all kimptor.f
ifort -c -g -warn all -check all kinetic.f
ifort -c -g -warn all -check all kmetal.f
ifort -c -g -warn all -check all kmpole.f
ifort -c -g -warn all -check all kopbend.f
ifort -c -g -warn all -check all kopdist.f
ifort -c -g -warn all -check all korbit.f
ifort -c -g -warn all -check all kpitors.f
ifort -c -g -warn all -check all kpolar.f
ifort -c -g -warn all -check all ksolv.f
ifort -c -g -warn all -check all kstrbnd.f
ifort -c -g -warn all -check all kstrtor.f
ifort -c -g -warn all -check all ktors.f
ifort -c -g -warn all -check all ktortor.f
ifort -c -g -warn all -check all kurey.f
ifort -c -g -warn all -check all kvdw.f
ifort -c -g -warn all -check all lattice.f
ifort -c -g -warn all -check all lbfgs.f
ifort -c -g -warn all -check all lights.f
ifort -c -g -warn all -check all makeint.f
ifort -c -g -warn all -check all makeref.f
ifort -c -g -warn all -check all makexyz.f
ifort -c -g -warn all -check all maxwell.f
ifort -c -g -warn all -check all mdinit.f
ifort -c -g -warn all -check all mdrest.f
ifort -c -g -warn all -check all mdsave.f
ifort -c -g -warn all -check all mdstat.f
ifort -c -g -warn all -check all mechanic.f
ifort -c -g -warn all -check all merge.f
ifort -c -g -warn all -check all minimize.f
ifort -c -g -warn all -check all minirot.f
ifort -c -g -warn all -check all minrigid.f
ifort -c -g -warn all -check all mol2xyz.f
ifort -c -g -warn all -check all molecule.f
ifort -c -g -warn all -check all molxyz.f
ifort -c -g -warn all -check all moments.f
ifort -c -g -warn all -check all monte.f
ifort -c -g -warn all -check all mutate.f
ifort -c -g -warn all -check all nblist.f
ifort -c -g -warn all -check all newton.f
ifort -c -g -warn all -check all newtrot.f
ifort -c -g -warn all -check all nextarg.f
ifort -c -g -warn all -check all nexttext.f
ifort -c -g -warn all -check all nose.f
ifort -c -g -warn all -check all nspline.f
ifort -c -g -warn all -check all nucleic.f
ifort -c -g -warn all -check all number.f
ifort -c -g -warn all -check all numeral.f
ifort -c -g -warn all -check all numgrad.f
ifort -c -g -warn all -check all ocvm.f
ifort -c -g -warn all -check all openend.f
ifort -c -g -warn all -check all optimize.f
ifort -c -g -warn all -check all optirot.f
ifort -c -g -warn all -check all optrigid.f
ifort -c -g -warn all -check all optsave.f
ifort -c -g -warn all -check all orbital.f
ifort -c -g -warn all -check all orient.f
ifort -c -g -warn all -check all orthog.f
ifort -c -g -warn all -check all overlap.f
ifort -c -g -warn all -check all path.f
ifort -c -g -warn all -check all pdbxyz.f
ifort -c -g -warn all -check all picalc.f
ifort -c -g -warn all -check all pmestuf.f
ifort -c -g -warn all -check all pmpb.f
ifort -c -g -warn all -check all polarize.f
ifort -c -g -warn all -check all poledit.f
ifort -c -g -warn all -check all polymer.f
ifort -c -g -warn all -check all potential.f
ifort -c -g -warn all -check all precise.f
ifort -c -g -warn all -check all pressure.f
ifort -c -g -warn all -check all prmedit.f
ifort -c -g -warn all -check all prmkey.f
ifort -c -g -warn all -check all promo.f
ifort -c -g -warn all -check all protein.f
ifort -c -g -warn all -check all prtdyn.f
ifort -c -g -warn all -check all prterr.f
ifort -c -g -warn all -check all prtint.f
ifort -c -g -warn all -check all prtmol2.f
ifort -c -g -warn all -check all prtpdb.f
ifort -c -g -warn all -check all prtprm.f
ifort -c -g -warn all -check all prtseq.f
ifort -c -g -warn all -check all prtxyz.f
ifort -c -g -warn all -check all pss.f
ifort -c -g -warn all -check all pssrigid.f
ifort -c -g -warn all -check all pssrot.f
ifort -c -g -warn all -check all qrfact.f
ifort -c -g -warn all -check all quatfit.f
ifort -c -g -warn all -check all radial.f
ifort -c -g -warn all -check all random.f
ifort -c -g -warn all -check all rattle.f
ifort -c -g -warn all -check all readdyn.f
ifort -c -g -warn all -check all readgau.f
ifort -c -g -warn all -check all readgdma.f
ifort -c -g -warn all -check all readint.f
ifort -c -g -warn all -check all readmol.f
ifort -c -g -warn all -check all readmol2.f
ifort -c -g -warn all -check all readpdb.f
ifort -c -g -warn all -check all readprm.f
ifort -c -g -warn all -check all readseq.f
ifort -c -g -warn all -check all readxyz.f
ifort -c -g -warn all -check all replica.f
ifort -c -g -warn all -check all respa.f
ifort -c -g -warn all -check all rgdstep.f
ifort -c -g -warn all -check all rings.f
ifort -c -g -warn all -check all rmsfit.f
ifort -c -g -warn all -check all rotlist.f
ifort -c -g -warn all -check all rotpole.f
ifort -c -g -warn all -check all saddle.f
ifort -c -g -warn all -check all scan.f
ifort -c -g -warn all -check all sdstep.f
ifort -c -g -warn all -check all search.f
ifort -c -g -warn all -check all server.f
ifort -c -g -warn all -check all shakeup.f
ifort -c -g -warn all -check all sigmoid.f
ifort -c -g -warn all -check all simplex.f
ifort -c -g -warn all -check all sktstuf.f
ifort -c -g -warn all -check all sniffer.f
ifort -c -g -warn all -check all sort.f
ifort -c -g -warn all -check all spacefill.f
ifort -c -g -warn all -check all spectrum.f
ifort -c -g -warn all -check all square.f
ifort -c -g -warn all -check all suffix.f
ifort -c -g -warn all -check all superpose.f
ifort -c -g -warn all -check all surface.f
ifort -c -g -warn all -check all surfatom.f
ifort -c -g -warn all -check all switch.f
ifort -c -g -warn all -check all tcgstuf.f
ifort -c -g -warn all -check all temper.f
ifort -c -g -warn all -check all testgrad.f
ifort -c -g -warn all -check all testhess.f
ifort -c -g -warn all -check all testpair.f
ifort -c -g -warn all -check all testpol.f
ifort -c -g -warn all -check all testrot.f
ifort -c -g -warn all -check all testvir.f
ifort -c -g -warn all -check all timer.f
ifort -c -g -warn all -check all timerot.f
ifort -c -g -warn all -check all tncg.f
ifort -c -g -warn all -check all torphase.f
ifort -c -g -warn all -check all torque.f
ifort -c -g -warn all -check all torsfit.f
ifort -c -g -warn all -check all torsions.f
ifort -c -g -warn all -check all trimtext.f
ifort -c -g -warn all -check all unitcell.f
ifort -c -g -warn all -check all valence.f
ifort -c -g -warn all -check all verlet.f
ifort -c -g -warn all -check all version.f
ifort -c -g -warn all -check all vibbig.f
ifort -c -g -warn all -check all vibrate.f
ifort -c -g -warn all -check all vibrot.f
ifort -c -g -warn all -check all volume.f
ifort -c -g -warn all -check all xtalfit.f
ifort -c -g -warn all -check all xtalmin.f
ifort -c -g -warn all -check all xyzatm.f
ifort -c -g -warn all -check all xyzedit.f
ifort -c -g -warn all -check all xyzint.f
ifort -c -g -warn all -check all xyzmol2.f
ifort -c -g -warn all -check all xyzpdb.f
ifort -c -g -warn all -check all zatom.f
