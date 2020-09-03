#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# RULES #

#/
# Runs JavaScript examples consecutively.
#
# ## Notes
#
# -   This rule is useful when wanting to glob for JavaScript examples files (e.g., run all JavaScript examples for a particular package).
# -   This rule **assumes** that examples files can be run using Node.js.
#
#
# @param {string} [EXAMPLES_FILTER] - file path pattern (e.g., `.*/math/base/special/abs/.*`)
#
# @example
# make examples-javascript
#
# @example
# make examples-javascript EXAMPLES_FILTER=".*/strided/common/.*"
#/
examples-javascript: $(NODE_MODULES)
	$(QUIET) $(FIND_EXAMPLES_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running example: $$file"; \
		NODE_ENV="$(NODE_ENV_EXAMPLES)" \
		NODE_PATH="$(NODE_PATH_EXAMPLES)" \
		$(NODE) $$file || exit 1; \
	done

.PHONY: examples-javascript

#/
# Runs a specified list of JavaScript examples consecutively.
#
# ## Notes
#
# -   This rule is useful when wanting to run a list of JavaScript examples files generated by some other command (e.g., a list of changed JavaScript examples files obtained via `git diff`).
# -   This rule **assumes** that examples files can be run using Node.js.
#
#
# @param {string} FILES - list of JavaScript example file paths
#
# @example
# make examples-javascript-files FILES='/foo/example.js /bar/example.js'
#/
examples-javascript-files: $(NODE_MODULES)
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running example: $$file"; \
		NODE_ENV="$(NODE_ENV_EXAMPLES)" \
		NODE_PATH="$(NODE_PATH_EXAMPLES)" \
		$(NODE) $$file || exit 1; \
	done

.PHONY: examples-javascript-files
