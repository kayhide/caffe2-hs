import           ClassyPrelude

import           Control.Lens
import           Data.Default        (def)
import           Data.ProtoLens      (showMessage, encodeMessage)

import qualified Proto.Caffe2        as Proto
import qualified Proto.Caffe2_Fields as Proto


main :: IO ()
main = do
  putStrLn "hello world"
  putStrLn . pack $ showMessage createLeNet

createLeNet :: Proto.NetDef
createLeNet =
  def
  & Proto.name .~ "mnist_train"
  & Proto.op .~
  [ def
    & Proto.name .~ "conv1"
    & Proto.type' .~ "Conv"
    & Proto.input .~ ["input", "conv1_w", "conv1_b"]
    & Proto.output .~ ["conv1"]
    & Proto.arg .~
    [ def & Proto.name .~ "stride" & Proto.i .~ 1
    , def & Proto.name .~ "pad" & Proto.i .~ 0
    , def & Proto.name .~ "kernel" & Proto.i .~ 5
    ]
  , def
    & Proto.name .~ "pool1"
    & Proto.type' .~ "MaxPool"
    & Proto.input .~ ["conv1"]
    & Proto.output .~ ["pool1"]
  , def
    & Proto.name .~ "conv2"
    & Proto.type' .~ "Conv"
    & Proto.input .~ ["pool1", "conv2_w", "conv2_b"]
    & Proto.output .~ ["conv2"]
    & Proto.arg .~
    [ def & Proto.name .~ "stride" & Proto.i .~ 1
    , def & Proto.name .~ "pad" & Proto.i .~ 0
    , def & Proto.name .~ "kernel" & Proto.i .~ 5
    ]
  , def
    & Proto.name .~ "pool2"
    & Proto.type' .~ "MaxPool"
    & Proto.input .~ ["conv2"]
    & Proto.output .~ ["pool2"]
  , def
    & Proto.name .~ "fc3"
    & Proto.type' .~ "FC"
    & Proto.input .~ ["pool1", "fc3_w", "fc3_b"]
    & Proto.output .~ ["fc3"]
  , def
    & Proto.name .~ "relu3"
    & Proto.type' .~ "Relu"
    & Proto.input .~ ["fc3"]
    & Proto.output .~ ["relu3"]
  , def
    & Proto.name .~ "fc4"
    & Proto.type' .~ "FC"
    & Proto.input .~ ["relu3", "fc4_w", "fc4_b"]
    & Proto.output .~ ["fc4"]
  , def
    & Proto.name .~ "softmax"
    & Proto.type' .~ "Softmax"
    & Proto.input .~ ["fc4"]
    & Proto.output .~ ["output"]
  ]
