??
??
B
AssignVariableOp
resource
value"dtype"
dtypetype?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype?
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ?
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
?
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 ?"serve*2.6.02v2.6.0-rc2-32-g919f693420e8??
t
dense/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*
shared_namedense/kernel
m
 dense/kernel/Read/ReadVariableOpReadVariableOpdense/kernel*
_output_shapes

:*
dtype0
l

dense/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_name
dense/bias
e
dense/bias/Read/ReadVariableOpReadVariableOp
dense/bias*
_output_shapes
:*
dtype0

NoOpNoOp
?	
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*?	
value?	B?	 B?	
?
layer-0
layer_with_weights-0
layer-1
regularization_losses
trainable_variables
	variables
	keras_api

signatures
R
regularization_losses
	trainable_variables

	variables
	keras_api
h

kernel
bias
regularization_losses
trainable_variables
	variables
	keras_api
 

0
1

0
1
?

layers
regularization_losses
trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses
	variables
metrics
 
 
 
 
?

layers
regularization_losses
	trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses

	variables
metrics
XV
VARIABLE_VALUEdense/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE
TR
VARIABLE_VALUE
dense/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE
 

0
1

0
1
?

layers
regularization_losses
trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses
	variables
 metrics

0
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
?
serving_default_input_1Placeholder*/
_output_shapes
:?????????*
dtype0*$
shape:?????????
?
StatefulPartitionedCallStatefulPartitionedCallserving_default_input_1dense/kernel
dense/bias*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? **
f%R#
!__inference_signature_wrapper_176
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename dense/kernel/Read/ReadVariableOpdense/bias/Read/ReadVariableOpConst*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *%
f R
__inference__traced_save_277
?
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamedense/kernel
dense/bias*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *(
f#R!
__inference__traced_restore_293??
?
?
(__inference_sequential_layer_call_fn_209

inputs
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *K
fFRD
B__inference_sequential_layer_call_and_return_conditional_losses_852
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?

?
>__inference_dense_layer_call_and_return_conditional_losses_239

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
MatMul?
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp?
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
C__inference_sequential_layer_call_and_return_conditional_losses_165
input_1
	dense_159:
	dense_161:
identity??dense/StatefulPartitionedCall?
flatten/PartitionedCallPartitionedCallinput_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_flatten_layer_call_and_return_conditional_losses_662
flatten/PartitionedCall?
dense/StatefulPartitionedCallStatefulPartitionedCall flatten/PartitionedCall:output:0	dense_159	dense_161*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *F
fAR?
=__inference_dense_layer_call_and_return_conditional_losses_782
dense/StatefulPartitionedCall?
IdentityIdentity&dense/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityn
NoOpNoOp^dense/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
\
@__inference_flatten_layer_call_and_return_conditional_losses_224

inputs
identity_
ConstConst*
_output_shapes
:*
dtype0*
valueB"????   2
Constg
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:?????????2	
Reshaped
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:?????????:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
C__inference_sequential_layer_call_and_return_conditional_losses_200

inputs6
$dense_matmul_readvariableop_resource:3
%dense_biasadd_readvariableop_resource:
identity??dense/BiasAdd/ReadVariableOp?dense/MatMul/ReadVariableOpo
flatten/ConstConst*
_output_shapes
:*
dtype0*
valueB"????   2
flatten/Const
flatten/ReshapeReshapeinputsflatten/Const:output:0*
T0*'
_output_shapes
:?????????2
flatten/Reshape?
dense/MatMul/ReadVariableOpReadVariableOp$dense_matmul_readvariableop_resource*
_output_shapes

:*
dtype02
dense/MatMul/ReadVariableOp?
dense/MatMulMatMulflatten/Reshape:output:0#dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
dense/MatMul?
dense/BiasAdd/ReadVariableOpReadVariableOp%dense_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02
dense/BiasAdd/ReadVariableOp?
dense/BiasAddBiasAdddense/MatMul:product:0$dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
dense/BiasAddq
IdentityIdentitydense/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identity?
NoOpNoOp^dense/BiasAdd/ReadVariableOp^dense/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2<
dense/BiasAdd/ReadVariableOpdense/BiasAdd/ReadVariableOp2:
dense/MatMul/ReadVariableOpdense/MatMul/ReadVariableOp:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
!__inference_signature_wrapper_176
input_1
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinput_1unknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *&
f!R
__inference__wrapped_model_532
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
?
'__inference_sequential_layer_call_fn_92
input_1
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinput_1unknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *K
fFRD
B__inference_sequential_layer_call_and_return_conditional_losses_852
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
[
?__inference_flatten_layer_call_and_return_conditional_losses_66

inputs
identity_
ConstConst*
_output_shapes
:*
dtype0*
valueB"????   2
Constg
ReshapeReshapeinputsConst:output:0*
T0*'
_output_shapes
:?????????2	
Reshaped
IdentityIdentityReshape:output:0*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:?????????:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?

?
=__inference_dense_layer_call_and_return_conditional_losses_78

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype02
MatMul/ReadVariableOps
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
MatMul?
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype02
BiasAdd/ReadVariableOp?
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2	
BiasAddk
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identity
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
__inference__wrapped_model_53
input_1A
/sequential_dense_matmul_readvariableop_resource:>
0sequential_dense_biasadd_readvariableop_resource:
identity??'sequential/dense/BiasAdd/ReadVariableOp?&sequential/dense/MatMul/ReadVariableOp?
sequential/flatten/ConstConst*
_output_shapes
:*
dtype0*
valueB"????   2
sequential/flatten/Const?
sequential/flatten/ReshapeReshapeinput_1!sequential/flatten/Const:output:0*
T0*'
_output_shapes
:?????????2
sequential/flatten/Reshape?
&sequential/dense/MatMul/ReadVariableOpReadVariableOp/sequential_dense_matmul_readvariableop_resource*
_output_shapes

:*
dtype02(
&sequential/dense/MatMul/ReadVariableOp?
sequential/dense/MatMulMatMul#sequential/flatten/Reshape:output:0.sequential/dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
sequential/dense/MatMul?
'sequential/dense/BiasAdd/ReadVariableOpReadVariableOp0sequential_dense_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02)
'sequential/dense/BiasAdd/ReadVariableOp?
sequential/dense/BiasAddBiasAdd!sequential/dense/MatMul:product:0/sequential/dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
sequential/dense/BiasAdd|
IdentityIdentity!sequential/dense/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identity?
NoOpNoOp(^sequential/dense/BiasAdd/ReadVariableOp'^sequential/dense/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2R
'sequential/dense/BiasAdd/ReadVariableOp'sequential/dense/BiasAdd/ReadVariableOp2P
&sequential/dense/MatMul/ReadVariableOp&sequential/dense/MatMul/ReadVariableOp:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
?
C__inference_sequential_layer_call_and_return_conditional_losses_155
input_1
	dense_149:
	dense_151:
identity??dense/StatefulPartitionedCall?
flatten/PartitionedCallPartitionedCallinput_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_flatten_layer_call_and_return_conditional_losses_662
flatten/PartitionedCall?
dense/StatefulPartitionedCallStatefulPartitionedCall flatten/PartitionedCall:output:0	dense_149	dense_151*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *F
fAR?
=__inference_dense_layer_call_and_return_conditional_losses_782
dense/StatefulPartitionedCall?
IdentityIdentity&dense/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityn
NoOpNoOp^dense/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
?
#__inference_dense_layer_call_fn_248

inputs
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *F
fAR?
=__inference_dense_layer_call_and_return_conditional_losses_782
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
C__inference_sequential_layer_call_and_return_conditional_losses_129

inputs
	dense_123:
	dense_125:
identity??dense/StatefulPartitionedCall?
flatten/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_flatten_layer_call_and_return_conditional_losses_662
flatten/PartitionedCall?
dense/StatefulPartitionedCallStatefulPartitionedCall flatten/PartitionedCall:output:0	dense_123	dense_125*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *F
fAR?
=__inference_dense_layer_call_and_return_conditional_losses_782
dense/StatefulPartitionedCall?
IdentityIdentity&dense/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityn
NoOpNoOp^dense/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
__inference__traced_save_277
file_prefix+
'savev2_dense_kernel_read_readvariableop)
%savev2_dense_bias_read_readvariableop
savev2_const

identity_1??MergeV2Checkpoints?
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*2
StaticRegexFullMatchc
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.part2
Constl
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part2	
Const_1?
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: 2
Selectt

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: 2

StringJoinZ

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :2

num_shards
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 2
ShardedFilename/shard?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 2
ShardedFilename?
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
SaveV2/tensor_names?
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B 2
SaveV2/shape_and_slices?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0'savev2_dense_kernel_read_readvariableop%savev2_dense_bias_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
22
SaveV2?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:2(
&MergeV2Checkpoints/checkpoint_prefixes?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 2
MergeV2Checkpointsr
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: 2

Identity_

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: 2

Identity_1c
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"!

identity_1Identity_1:output:0*'
_input_shapes
: ::: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:: 

_output_shapes
::

_output_shapes
: 
?
?
B__inference_sequential_layer_call_and_return_conditional_losses_85

inputs
dense_79:
dense_81:
identity??dense/StatefulPartitionedCall?
flatten/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_flatten_layer_call_and_return_conditional_losses_662
flatten/PartitionedCall?
dense/StatefulPartitionedCallStatefulPartitionedCall flatten/PartitionedCall:output:0dense_79dense_81*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *F
fAR?
=__inference_dense_layer_call_and_return_conditional_losses_782
dense/StatefulPartitionedCall?
IdentityIdentity&dense/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityn
NoOpNoOp^dense/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2>
dense/StatefulPartitionedCalldense/StatefulPartitionedCall:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
C__inference_sequential_layer_call_and_return_conditional_losses_188

inputs6
$dense_matmul_readvariableop_resource:3
%dense_biasadd_readvariableop_resource:
identity??dense/BiasAdd/ReadVariableOp?dense/MatMul/ReadVariableOpo
flatten/ConstConst*
_output_shapes
:*
dtype0*
valueB"????   2
flatten/Const
flatten/ReshapeReshapeinputsflatten/Const:output:0*
T0*'
_output_shapes
:?????????2
flatten/Reshape?
dense/MatMul/ReadVariableOpReadVariableOp$dense_matmul_readvariableop_resource*
_output_shapes

:*
dtype02
dense/MatMul/ReadVariableOp?
dense/MatMulMatMulflatten/Reshape:output:0#dense/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
dense/MatMul?
dense/BiasAdd/ReadVariableOpReadVariableOp%dense_biasadd_readvariableop_resource*
_output_shapes
:*
dtype02
dense/BiasAdd/ReadVariableOp?
dense/BiasAddBiasAdddense/MatMul:product:0$dense/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????2
dense/BiasAddq
IdentityIdentitydense/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identity?
NoOpNoOp^dense/BiasAdd/ReadVariableOp^dense/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 2<
dense/BiasAdd/ReadVariableOpdense/BiasAdd/ReadVariableOp2:
dense/MatMul/ReadVariableOpdense/MatMul/ReadVariableOp:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
(__inference_sequential_layer_call_fn_145
input_1
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinput_1unknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1292
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:X T
/
_output_shapes
:?????????
!
_user_specified_name	input_1
?
A
%__inference_flatten_layer_call_fn_229

inputs
identity?
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_flatten_layer_call_and_return_conditional_losses_662
PartitionedCalll
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:?????????:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
(__inference_sequential_layer_call_fn_218

inputs
unknown:
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1292
StatefulPartitionedCall{
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????2

Identityh
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 2
NoOp"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
__inference__traced_restore_293
file_prefix/
assignvariableop_dense_kernel:+
assignvariableop_1_dense_bias:

identity_3??AssignVariableOp?AssignVariableOp_1?
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
RestoreV2/tensor_names?
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B 2
RestoreV2/shape_and_slices?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0* 
_output_shapes
:::*
dtypes
22
	RestoreV2g
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:2

Identity?
AssignVariableOpAssignVariableOpassignvariableop_dense_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOpk

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:2

Identity_1?
AssignVariableOp_1AssignVariableOpassignvariableop_1_dense_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_19
NoOpNoOp"/device:CPU:0*
_output_shapes
 2
NoOp?

Identity_2Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^NoOp"/device:CPU:0*
T0*
_output_shapes
: 2

Identity_2c

Identity_3IdentityIdentity_2:output:0^NoOp_1*
T0*
_output_shapes
: 2

Identity_3z
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1*"
_acd_function_control_output(*
_output_shapes
 2
NoOp_1"!

identity_3Identity_3:output:0*
_input_shapes
: : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_1:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix"?L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*?
serving_default?
C
input_18
serving_default_input_1:0?????????9
dense0
StatefulPartitionedCall:0?????????tensorflow/serving/predict:?5
?
layer-0
layer_with_weights-0
layer-1
regularization_losses
trainable_variables
	variables
	keras_api

signatures
*!&call_and_return_all_conditional_losses
"_default_save_signature
#__call__"
_tf_keras_sequential
?
regularization_losses
	trainable_variables

	variables
	keras_api
*$&call_and_return_all_conditional_losses
%__call__"
_tf_keras_layer
?

kernel
bias
regularization_losses
trainable_variables
	variables
	keras_api
*&&call_and_return_all_conditional_losses
'__call__"
_tf_keras_layer
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
?

layers
regularization_losses
trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses
	variables
metrics
#__call__
"_default_save_signature
*!&call_and_return_all_conditional_losses
&!"call_and_return_conditional_losses"
_generic_user_object
,
(serving_default"
signature_map
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
?

layers
regularization_losses
	trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses

	variables
metrics
%__call__
*$&call_and_return_all_conditional_losses
&$"call_and_return_conditional_losses"
_generic_user_object
:2dense/kernel
:2
dense/bias
 "
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
?

layers
regularization_losses
trainable_variables
non_trainable_variables
layer_metrics
layer_regularization_losses
	variables
 metrics
'__call__
*&&call_and_return_all_conditional_losses
&&"call_and_return_conditional_losses"
_generic_user_object
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
?2?
C__inference_sequential_layer_call_and_return_conditional_losses_188
C__inference_sequential_layer_call_and_return_conditional_losses_200
C__inference_sequential_layer_call_and_return_conditional_losses_155
C__inference_sequential_layer_call_and_return_conditional_losses_165?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?B?
__inference__wrapped_model_53input_1"?
???
FullArgSpec
args? 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
'__inference_sequential_layer_call_fn_92
(__inference_sequential_layer_call_fn_209
(__inference_sequential_layer_call_fn_218
(__inference_sequential_layer_call_fn_145?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
@__inference_flatten_layer_call_and_return_conditional_losses_224?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
%__inference_flatten_layer_call_fn_229?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
>__inference_dense_layer_call_and_return_conditional_losses_239?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
#__inference_dense_layer_call_fn_248?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
!__inference_signature_wrapper_176input_1"?
???
FullArgSpec
args? 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 ?
__inference__wrapped_model_53m8?5
.?+
)?&
input_1?????????
? "-?*
(
dense?
dense??????????
>__inference_dense_layer_call_and_return_conditional_losses_239\/?,
%?"
 ?
inputs?????????
? "%?"
?
0?????????
? v
#__inference_dense_layer_call_fn_248O/?,
%?"
 ?
inputs?????????
? "???????????
@__inference_flatten_layer_call_and_return_conditional_losses_224`7?4
-?*
(?%
inputs?????????
? "%?"
?
0?????????
? |
%__inference_flatten_layer_call_fn_229S7?4
-?*
(?%
inputs?????????
? "???????????
C__inference_sequential_layer_call_and_return_conditional_losses_155m@?=
6?3
)?&
input_1?????????
p 

 
? "%?"
?
0?????????
? ?
C__inference_sequential_layer_call_and_return_conditional_losses_165m@?=
6?3
)?&
input_1?????????
p

 
? "%?"
?
0?????????
? ?
C__inference_sequential_layer_call_and_return_conditional_losses_188l??<
5?2
(?%
inputs?????????
p 

 
? "%?"
?
0?????????
? ?
C__inference_sequential_layer_call_and_return_conditional_losses_200l??<
5?2
(?%
inputs?????????
p

 
? "%?"
?
0?????????
? ?
(__inference_sequential_layer_call_fn_145`@?=
6?3
)?&
input_1?????????
p

 
? "???????????
(__inference_sequential_layer_call_fn_209_??<
5?2
(?%
inputs?????????
p 

 
? "???????????
(__inference_sequential_layer_call_fn_218_??<
5?2
(?%
inputs?????????
p

 
? "???????????
'__inference_sequential_layer_call_fn_92`@?=
6?3
)?&
input_1?????????
p 

 
? "???????????
!__inference_signature_wrapper_176xC?@
? 
9?6
4
input_1)?&
input_1?????????"-?*
(
dense?
dense?????????