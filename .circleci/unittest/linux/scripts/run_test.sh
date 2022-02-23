#!/usr/bin/env bash

set -e

export IN_CI=1
mkdir test-reports
eval "$(./conda/bin/conda shell.bash hook)"
conda activate ./env

python -m torch.utils.collect_env

# test_functorch_lagging_op_db.py: Only run this locally because it checks
# the functorch lagging op db vs PyTorch's op db.
EXIT_STATUS=0
python test/test_ops.py -k 'test_vmapvjpvjp' -v || EXIT_STATUS=$?
exit $EXIT_STATUS
