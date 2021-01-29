import io
import os
import setuptools

here = os.path.abspath(os.path.dirname(__file__))

about = {}
with io.open(
    os.path.join(here, "GAUnitLibrary", "__about__.py"), "r", encoding="utf-8"
) as f:
    exec(f.read(), about)
with io.open("README.md", "r", encoding="utf8") as f:
    long_description = f.read()

setuptools.setup(
    name="robotframework-gaunitlibrary",
    version=about["__version__"],
    author="Vincent Cabanis",
    author_email="touch@cabanis.fr",
    description="GAUnitLibrary is a Robot Framework library to interface with GAUnit",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/VinceCabs/robotframework-gaunitlibrary",
    packages=["GAUnitLibrary"],
    license="MIT",
    python_requires=">=3.6",
    install_requires=["gaunit==0.3.2"],
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Topic :: Software Development :: Testing",
    ],
)
