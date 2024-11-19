#!/bin/bash
#SBATCH --cpus-per-task=4
#SBATCH --error=/perm/sp3c/extractions/extrae_station4.1
#SBATCH --mem-per-cpu=4000
#SBATCH --job-name=gl_bd
#SBATCH --ntasks=1
#SBATCH --output=/perm/sp3c/extractions/extrae_station4.1
#SBATCH --qos=nf
#SBATCH --time=0:10:00

export KMP_STACKSIZE=128m
export MPPEXEC="srun"
export MPPGL=""
export NPOOLS=1
export NPROC=1
export NPROCX=1
export NPROCY=1
export OMP_NUM_THREADS=1
initcmd="kill=scancel $SLURM_JOB_ID&&view="
killcmd="scancel $SLURM_JOB_ID"
eojcmd=""
ulimit -S -s unlimited || ulimit -s
ulimit -S -m unlimited || ulimit -m
ulimit -S -d unlimited || ulimit -d

#set -x
user=sp3c # Put your ATOS user here
EXPE=cy46_fordeodeverif_orig #Name of a Harmonie experiment in your $HOME/hm_home/
EXP=$EXPE
source /home/$user/hm_home/${EXPE}/Env_system
GLDIR=$SCRATCH/hm_home/${EXPE}/install/bin/  # Location of your gl executable


#Name of a Harmonie experiment with data available in $SCRATCH
exp=46h1_CTRL
#Name of the station to interpolate and coordinates
station=Bilos
lat=44.4936
lon=-0.95608

mkdir /perm/$user/extractions/
DIR="/perm/$user/extractions/${station}"
mkdir -p $DIR
datetime_at_start=`echo $(date)`
cd $DIR

#Generate namelist for surface data
cat <<EOF > nam_extraction_flux
&naminterp
 outgeo%nlon = 1,
 outgeo%nlat = 1,
 outgeo%nlev = -1,
 outgeo%gridtype='regular_ll'
 outgeo%arakawa=  'a',
 order = 1, ! 0: nearest point , 1: bi-linear
 readkey%faname ='X001FMV_P','X001FMU_P','X001LE_P','X001H_P','X002FMV_P','X002FMU_P','X002LE_P','X002H_P','X001LEC_P','X001HC_P','X002LEC_P','X002HC_P','X001TG1','X002TG1','X001TG2','X002TG2','X001WG1','X002WG1','X001WG2','X002WG2','X001LMO','X002LMO','X001DH','X002DH','X001T2M_P','X002T2M_P','X001Q2M_P','X002Q2M_P','X001HU2M_P','X002HU2M_P','X001W10M_P','X002W10M_P','X001RI_P','X002RI_P','X001CD_P','X002CD_P','X001CH_P','X002CH_P','X001RN_P','X002RN_P','X001GFLUX_P','X002GFLUX_P','X001EMIS_ISBA','X002EMIS_ISBA','X001FMUC_P','X001FMVC_P','X002FMUC_P','X002FMVC_P'
 user_trans%full_name ='X001FMV_P','X001FMU_P','X001LE_P','X001H_P','X002FMV_P','X002FMU_P','X002LE_P','X002H_P','X001LEC_P','X001HC_P','X002LEC_P','X002HC_P','X001TG1','X002TG1','X001TG2','X002TG2','X001WG1','X002WG1','X001WG2','X002WG2','X001LMO','X002LMO','X001DH','X002DH','X001T2M_P','X002T2M_P','X001Q2M_P','X002Q2M_P','X001HU2M_P','X002HU2M_P','X001W10M_P','X002W10M_P','X001RI_P','X002RI_P','X001CD_P','X002CD_P','X001CH_P','X002CH_P','X001RN_P','X002RN_P','X001GFLUX_P','X002GFLUX_P','X001EMIS_ISBA','X002EMIS_ISBA','X001FMUC_P','X001FMVC_P','X002FMUC_P','X002FMVC_P'


 user_trans%t2v=1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
 user_trans%pid=124,125,132,122,124,125,132,122,132,122,132,122,11,11,11,11,137,137,138,138,94,94,95,95,11,11,51,51,52,52,35,35,1,1,98,98,97,97,2,2,5,5,21,21,125,124,125,124
 user_trans%level=830,830,830,830,840,840,840,840,830,830,840,840,831,841,832,842,830,840,831,841,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,840,830,830,840,840,
 user_trans%levtype='heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround',
 user_trans%tri=1,1,1,1,1,1,1,1,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,4,4,4,
 linterp_field = f,
 gplat = $lat,
 gplon = $lon,
/


EOF

#generate namelist for radiative data
cat <<EOF > nam_extraction_rad
&naminterp
 outgeo%nlon = 1,
 outgeo%nlat = 1,
 outgeo%nlev = -1,
 outgeo%gridtype='regular_ll'
 outgeo%arakawa=  'A',
 order = 1, ! 0: nearest point , 1: bi-linear
 readkey%faname='SOMMRAYT.SOLAIRE','SURFRAYT.SOLAIRE','SOMMRAYT.TERREST','SURFRAYT.TERREST','S065WIND.U.PHYS','S065WIND.V.PHYS'
 user_trans%full_name ='SOMMRAYT.SOLAIRE','SURFRAYT.SOLAIRE','SOMMRAYT.TERREST','SURFRAYT.TERREST','S065WIND.U.PHYS','S065WIND.V.PHYS'
 user_trans%t2v=1,1,1,1,1,1
 user_trans%pid=124,125,132,122,033,034
 user_trans%level=830,830,830,830,65,65
 user_trans%levtype='heigthAboveGround','heigthAboveGround','heigthAboveGround','heigthAboveGround','hybrid','hybrid'
 user_trans%tri=1,1,1,1,1,1
 linterp_field = f,
 gplat = $lat,
 gplon = $lon,
/

EOF


#loop through experiment runs as desired, to process historic atmospheric and surface files
month=08
year=2021

for day in 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do

for run in 00 03 06 09 12 15 18 21; do 

for hour in 00 01 02 03; do

DIRARCHIVE=$SCRATCH/../$user/hm_home/${exp}/archive/${year}/$month/$day/$run/
inputfich=$DIRARCHIVE/ICMSHSELE+00${hour}.sfx
output_gl=${exp}fc${month}${year}${day}${run}+0${hour}sfx_asc.txt

echo 'Processing:  '$day' '$run' '$hour
echo 'in file: '$localfich

gl=$GLDIR/gl
$gl $inputfich -f -n nam_extraction_flux -o $output_gl

line=$(sed -n 52p $output_gl)
#Concatenate the last line of the output, containing the interpolated variables, into a single file, along with a timestamp
echo $month $day $run $hour $line
echo $month $day $run $hour $line >> ${exp}_${station}_${month}${year}_sfxdata.txt

inputfich=$DIRARCHIVE/ICMSHHARM+00${hour}
output_gl=${exp}fc${month}${year}${day}${run}+0${hour}atm_asc_UV.txt

echo 'Processing:  '$day' '$run' '$hour
echo 'in file: '$localfich

gl=$GLDIR/gl
$gl $inputfich -f -n nam_extraction_rad -o $output_gl

linea=$(sed -n 10p $output_gl)
#Concatenate the last line of the output, containing the interpolated variables, into a single file, along with a timestamp
echo $month $day $run $hour $linea
echo $month $day $run $hour $linea >> ${exp}_${station}_${month}${year}_atmdata.txt

done
done
done
