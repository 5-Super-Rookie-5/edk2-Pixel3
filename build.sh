#!/usr/bin/bash
 Identity() {
  case $MACHINE in
      JENKINS)
          EDK2="edk2-pixel3_master"
          EDK2_PLATFORMS="edk2-pixle3_platforms_master"
          IS_AUTORUN=no
      ;;
      *)
          EDK2="edk2"
          EDK2_PLATFORMS="edk2-platforms"
          IS_AUTORUN=yes
      ;;
  esac
}

 initialization() {
  export PACKAGES_PATH=$PWD/../$EDK2:$PWD/../$EDK2_PLATFORMS:$PWD
  export WORKSPACE=$PWD/output
  export UEFIFD=$WORKSPACE/Build/Pixel3/DEBUG_GCC5/FV/PIXEL3PKG_UEFI.fd
  export KERNEL_IMAGES=$WORKSPACE/blueline-aarch64.img
  export RAMDISK=$WORKSPACE/../androidboot/ramdisk
  export KERNEL_CONFIG=$WORKSPACE/../androidboot/android.cfg
  export UEFI_IMAGE=$WORKSPACE/../boot-blueline.img
  . ../$EDK2/edksetup.sh
}


 make_uefi_image() {
  GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p Pixel3Pkg/blueline.dsc
}

 make_fake_kernel() {
  gzip -c < $UEFIFD > $KERNEL_IMAGES
}

 appenddtb() {
  for DTB in $PWD/*.dtb; do
    cat $DTB >> $KERNEL_IMAGES
  done
}

 androidboot() {
  $(which "abootimg") --create $UEFI_IMAGE -k $KERNEL_IMAGES -r $RAMDISK -f $KERNEL_CONFIG
}

 clean() {
  make -C $WORKSPACE clean
  if [ "$IS_AUTORUN" == "no" ]; then make clean; fi
}

 make_all() {
  while [ $# != 0 ];
    do
      local EXECUTE_COMMAND=$1
      printf "Start the task: $EXECUTE_COMMAND\n"
      $EXECUTE_COMMAND
        case $? in
          0)
            printf "Successful task '$EXECUTE_COMMAND' execution!\n"
            ;;
          1)
            printf "Task '$EXECUTE_COMMAND' execution failed!\n"
            exit 1
            ;;
        esac
    shift;
  done
}

  Identity

  case $IS_AUTORUN in
    yes)
        initialization
        make_all makedtc makedtb make_uefi_image make_fake_kernel appenddtb androidboot clean
        ;;
    no)
        initialization
        $1
        ;;
  esac

