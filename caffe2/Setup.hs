import Foreign.Hoppy.Setup
main = hsMain $
  ProjectConfig
  { generatorExecutableName = "caffe2-generator"
  , cppPackageName = "caffe2-cpp"
  , cppSourcesDir = "cpp"
  , hsSourcesDir = "src_gen"
  }
