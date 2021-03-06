# The repository that contains the GITHUB pages checkout
GITHUB_PAGES=../pyblue-ghpages

all: docs

README.rst: README.md
	# Generate .rst from .md
	# PyPi accepts only rst files in long description.
	pandoc README.md -o README.rst

rst: README.rst

docs:
	# View the documentation.
	pyblue serve -r docs -v

pypi: rst
	python setup.py sdist upload

pages: rst
	# Generate/commit/push documentation into the GitHub Page repository.
	cd ${GITHUB_PAGES} && git pull
	pyblue -r docs -o ${GITHUB_PAGES}
	cd ${GITHUB_PAGES} && git commit -am "updated the docs" && git push