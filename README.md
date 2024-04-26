# aw-python311-docker

This repository contains a test case for a docx -> txt conversion using aspose-words for python in a docker container. The base image is `python:3.11`

To run the test, execute the following commands:

```bash
docker build . -t aw-python-test
docker run -e DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true aw-python-test
```

It should fail with the following error:

```
Traceback (most recent call last):
  File "/home/convert.py", line 7, in <module>
    doc.save('example.txt')
RuntimeError: Proxy error(CultureNotFoundException): Culture is not supported. (Parameter 'culture')
1033 (0x0409) is an invalid culture identifier.
```

A variant of the test is setting the environment variable `DOTNET_SYSTEM_GLOBALIZATION_INVARIANT` to `false`:

Execute (with the docker image already built)
```bash
docker run -e DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false aw-python-test
```

This fails with the following error:

```
Process terminated. Couldn't find a valid ICU package installed on the system. Set the configuration flag System.Globalization.Invariant to true if you want to run with no globalization support.
   at System.Environment.FailFast(System.String)
   at System.Globalization.GlobalizationMode.GetGlobalizationInvariantMode()
   at System.Globalization.GlobalizationMode..cctor()
   at System.Globalization.CultureData.CreateCultureWithInvariantData()
   at System.Globalization.CultureData.get_Invariant()
   at System.Globalization.CultureInfo..cctor()
   at System.StringComparer..cctor()
   at System.StringComparer.get_OrdinalIgnoreCase()
   at System.Text.EncodingTable..cctor()
   at System.Text.EncodingTable.GetCodePageFromName(System.String)
   at System.Text.CodePagesEncodingProvider.GetEncoding(System.String)
   at System.Text.EncodingProvider.GetEncodingFromProvider(System.String)
   at System.Text.Encoding.GetEncoding(System.String)
   at Aspose.WrpGen.Interop.GenericMarshaler..cctor()
   at Aspose.WrpGen.Interop.GenericMarshaler.ToString(Aspose.WrpGen.Interop.PyStringArg*)
   at WrpNs_Aspose.WrpNs_Words.WrpCs_License_C070DFB8.call_000_SetLicense(IntPtr, Aspose.WrpGen.Interop.PyStringArg*)
```

It is unclear which packages have to be installed, to make the "ICU package error" go away. The `icu-devtools` package is already installed in the docker image. Issuing the command

```bash
apt list | grep icu
```

has the following output:

```
icu-devtools/now 72.1-3 amd64 [installed,local]
libicu-dev/now 72.1-3 amd64 [installed,local]
libicu72/now 72.1-3 amd64 [installed,local]
```
