import           Foreign.Hoppy.Generator.Main  (defaultMain)
import           Foreign.Hoppy.Generator.Spec  (Class, Export (..), Function,
                                                Interface, Module,
                                                Purity (Nonpure),
                                                addReqIncludes, ident, ident1,
                                                includeLocal, includeStd,
                                                interface,
                                                interfaceAddHaskellModuleBase,
                                                makeClass, makeFn, makeModule,
                                                mkConstMethod, mkCtor,
                                                moduleAddExports, moduleModify',
                                                moduleSetCppPath,
                                                moduleSetHppPath, toExtName)
import           Foreign.Hoppy.Generator.Std   (c_string, mod_std)
import           Foreign.Hoppy.Generator.Types (constT, objT, ptrT, refT)


main :: IO ()
main = defaultMain interfaceResult

interfaceResult :: Either String Interface
interfaceResult = do
  iface <- interface "caffe2"
           [ mod_wrapper
           , mod_std
           ]
  interfaceAddHaskellModuleBase ["Caffe2"] iface

mod_wrapper :: Module
mod_wrapper =
  moduleModify' (makeModule "wrapper" "wrapper.hpp" "wrapper.cpp") $
  moduleAddExports
  [ ExportClass c_Blob
  , ExportClass c_Workspace
  ]

c_Blob :: Class
c_Blob =
  addReqIncludes
  [ includeStd "caffe2/core/init.h"
  , includeStd "caffe2/core/blob.h"
  ] $
  makeClass (ident1 "caffe2" "Blob") (Just $ toExtName "Blob") [] []

c_Workspace :: Class
c_Workspace =
  addReqIncludes
  [ includeStd "caffe2/core/init.h"
  , includeStd "caffe2/core/blob.h"
  , includeStd "caffe2/core/net.h"
  , includeStd "caffe2/core/operator.h"
  ] $
  makeClass (ident1 "caffe2" "Workspace") (Just $ toExtName "Workspace")
  []
  [ mkCtor "new" []
  , mkConstMethod "GetBlob" [refT . constT $ objT c_string] (ptrT . constT $ objT c_Blob)
  ]
