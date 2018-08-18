import Foreign.Hoppy.Setup
main = cppMain $
  ProjectConfig
  { generatorExecutableName = "caffe2-generator"
  , cppPackageName = "caffe2-cpp"
  , cppSourcesDir = "cpp"
  , hsSourcesDir = "src"
  }
