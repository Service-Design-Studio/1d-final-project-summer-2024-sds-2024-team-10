# -*- coding: utf-8 -*-
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
from collections import OrderedDict
import os
import re
from typing import Dict, Mapping, MutableMapping, MutableSequence, Optional, Iterable, Iterator, Sequence, Tuple, Type, Union, cast

from googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1 import gapic_version as package_version

from google.api_core import client_options as client_options_lib
from google.api_core import exceptions as core_exceptions
from google.api_core import gapic_v1
from google.api_core import retry as retries
from google.auth import credentials as ga_credentials             # type: ignore
from google.auth.transport import mtls                            # type: ignore
from google.auth.transport.grpc import SslCredentials             # type: ignore
from google.auth.exceptions import MutualTLSChannelError          # type: ignore
from google.oauth2 import service_account                         # type: ignore

try:
    OptionalRetry = Union[retries.Retry, gapic_v1.method._MethodDefault]
except AttributeError:  # pragma: NO COVER
    OptionalRetry = Union[retries.Retry, object]  # type: ignore

from google.api import httpbody_pb2  # type: ignore
from cloudsdk.google.protobuf import any_pb2  # type: ignore
from cloudsdk.google.protobuf import struct_pb2  # type: ignore
from googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types import content
from googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types import explanation
from googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types import prediction_service
from googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types import types
from .transports.base import PredictionServiceTransport, DEFAULT_CLIENT_INFO
from .transports.grpc import PredictionServiceGrpcTransport
from .transports.grpc_asyncio import PredictionServiceGrpcAsyncIOTransport
from .transports.rest import PredictionServiceRestTransport


class PredictionServiceClientMeta(type):
    """Metaclass for the PredictionService client.

    This provides class-level methods for building and retrieving
    support objects (e.g. transport) without polluting the client instance
    objects.
    """
    _transport_registry = OrderedDict()  # type: Dict[str, Type[PredictionServiceTransport]]
    _transport_registry["grpc"] = PredictionServiceGrpcTransport
    _transport_registry["grpc_asyncio"] = PredictionServiceGrpcAsyncIOTransport
    _transport_registry["rest"] = PredictionServiceRestTransport

    def get_transport_class(cls,
            label: Optional[str] = None,
        ) -> Type[PredictionServiceTransport]:
        """Returns an appropriate transport class.

        Args:
            label: The name of the desired transport. If none is
                provided, then the first transport in the registry is used.

        Returns:
            The transport class to use.
        """
        # If a specific transport is requested, return that one.
        if label:
            return cls._transport_registry[label]

        # No transport is requested; return the default (that is, the first one
        # in the dictionary).
        return next(iter(cls._transport_registry.values()))


class PredictionServiceClient(metaclass=PredictionServiceClientMeta):
    """A service for online predictions and explanations."""

    @staticmethod
    def _get_default_mtls_endpoint(api_endpoint):
        """Converts api endpoint to mTLS endpoint.

        Convert "*.sandbox.googleapis.com" and "*.googleapis.com" to
        "*.mtls.sandbox.googleapis.com" and "*.mtls.googleapis.com" respectively.
        Args:
            api_endpoint (Optional[str]): the api endpoint to convert.
        Returns:
            str: converted mTLS api endpoint.
        """
        if not api_endpoint:
            return api_endpoint

        mtls_endpoint_re = re.compile(
            r"(?P<name>[^.]+)(?P<mtls>\.mtls)?(?P<sandbox>\.sandbox)?(?P<googledomain>\.googleapis\.com)?"
        )

        m = mtls_endpoint_re.match(api_endpoint)
        name, mtls, sandbox, googledomain = m.groups()
        if mtls or not googledomain:
            return api_endpoint

        if sandbox:
            return api_endpoint.replace(
                "sandbox.googleapis.com", "mtls.sandbox.googleapis.com"
            )

        return api_endpoint.replace(".googleapis.com", ".mtls.googleapis.com")

    DEFAULT_ENDPOINT = "aiplatform.googleapis.com"
    DEFAULT_MTLS_ENDPOINT = _get_default_mtls_endpoint.__func__(  # type: ignore
        DEFAULT_ENDPOINT
    )

    @classmethod
    def from_service_account_info(cls, info: dict, *args, **kwargs):
        """Creates an instance of this client using the provided credentials
            info.

        Args:
            info (dict): The service account private key info.
            args: Additional arguments to pass to the constructor.
            kwargs: Additional arguments to pass to the constructor.

        Returns:
            PredictionServiceClient: The constructed client.
        """
        credentials = service_account.Credentials.from_service_account_info(info)
        kwargs["credentials"] = credentials
        return cls(*args, **kwargs)

    @classmethod
    def from_service_account_file(cls, filename: str, *args, **kwargs):
        """Creates an instance of this client using the provided credentials
            file.

        Args:
            filename (str): The path to the service account private key json
                file.
            args: Additional arguments to pass to the constructor.
            kwargs: Additional arguments to pass to the constructor.

        Returns:
            PredictionServiceClient: The constructed client.
        """
        credentials = service_account.Credentials.from_service_account_file(
            filename)
        kwargs["credentials"] = credentials
        return cls(*args, **kwargs)

    from_service_account_json = from_service_account_file

    @property
    def transport(self) -> PredictionServiceTransport:
        """Returns the transport used by the client instance.

        Returns:
            PredictionServiceTransport: The transport used by the client
                instance.
        """
        return self._transport

    @staticmethod
    def common_billing_account_path(billing_account: str, ) -> str:
        """Returns a fully-qualified billing_account string."""
        return "billingAccounts/{billing_account}".format(billing_account=billing_account, )

    @staticmethod
    def parse_common_billing_account_path(path: str) -> Dict[str,str]:
        """Parse a billing_account path into its component segments."""
        m = re.match(r"^billingAccounts/(?P<billing_account>.+?)$", path)
        return m.groupdict() if m else {}

    @staticmethod
    def common_folder_path(folder: str, ) -> str:
        """Returns a fully-qualified folder string."""
        return "folders/{folder}".format(folder=folder, )

    @staticmethod
    def parse_common_folder_path(path: str) -> Dict[str,str]:
        """Parse a folder path into its component segments."""
        m = re.match(r"^folders/(?P<folder>.+?)$", path)
        return m.groupdict() if m else {}

    @staticmethod
    def common_organization_path(organization: str, ) -> str:
        """Returns a fully-qualified organization string."""
        return "organizations/{organization}".format(organization=organization, )

    @staticmethod
    def parse_common_organization_path(path: str) -> Dict[str,str]:
        """Parse a organization path into its component segments."""
        m = re.match(r"^organizations/(?P<organization>.+?)$", path)
        return m.groupdict() if m else {}

    @staticmethod
    def common_project_path(project: str, ) -> str:
        """Returns a fully-qualified project string."""
        return "projects/{project}".format(project=project, )

    @staticmethod
    def parse_common_project_path(path: str) -> Dict[str,str]:
        """Parse a project path into its component segments."""
        m = re.match(r"^projects/(?P<project>.+?)$", path)
        return m.groupdict() if m else {}

    @staticmethod
    def common_location_path(project: str, location: str, ) -> str:
        """Returns a fully-qualified location string."""
        return "projects/{project}/locations/{location}".format(project=project, location=location, )

    @staticmethod
    def parse_common_location_path(path: str) -> Dict[str,str]:
        """Parse a location path into its component segments."""
        m = re.match(r"^projects/(?P<project>.+?)/locations/(?P<location>.+?)$", path)
        return m.groupdict() if m else {}

    @classmethod
    def get_mtls_endpoint_and_cert_source(cls, client_options: Optional[client_options_lib.ClientOptions] = None):
        """Return the API endpoint and client cert source for mutual TLS.

        The client cert source is determined in the following order:
        (1) if `GOOGLE_API_USE_CLIENT_CERTIFICATE` environment variable is not "true", the
        client cert source is None.
        (2) if `client_options.client_cert_source` is provided, use the provided one; if the
        default client cert source exists, use the default one; otherwise the client cert
        source is None.

        The API endpoint is determined in the following order:
        (1) if `client_options.api_endpoint` if provided, use the provided one.
        (2) if `GOOGLE_API_USE_CLIENT_CERTIFICATE` environment variable is "always", use the
        default mTLS endpoint; if the environment variable is "never", use the default API
        endpoint; otherwise if client cert source exists, use the default mTLS endpoint, otherwise
        use the default API endpoint.

        More details can be found at https://google.aip.dev/auth/4114.

        Args:
            client_options (google.api_core.client_options.ClientOptions): Custom options for the
                client. Only the `api_endpoint` and `client_cert_source` properties may be used
                in this method.

        Returns:
            Tuple[str, Callable[[], Tuple[bytes, bytes]]]: returns the API endpoint and the
                client cert source to use.

        Raises:
            google.auth.exceptions.MutualTLSChannelError: If any errors happen.
        """
        if client_options is None:
            client_options = client_options_lib.ClientOptions()
        use_client_cert = os.getenv("GOOGLE_API_USE_CLIENT_CERTIFICATE", "false")
        use_mtls_endpoint = os.getenv("GOOGLE_API_USE_MTLS_ENDPOINT", "auto")
        if use_client_cert not in ("true", "false"):
            raise ValueError("Environment variable `GOOGLE_API_USE_CLIENT_CERTIFICATE` must be either `true` or `false`")
        if use_mtls_endpoint not in ("auto", "never", "always"):
            raise MutualTLSChannelError("Environment variable `GOOGLE_API_USE_MTLS_ENDPOINT` must be `never`, `auto` or `always`")

        # Figure out the client cert source to use.
        client_cert_source = None
        if use_client_cert == "true":
            if client_options.client_cert_source:
                client_cert_source = client_options.client_cert_source
            elif mtls.has_default_client_cert_source():
                client_cert_source = mtls.default_client_cert_source()

        # Figure out which api endpoint to use.
        if client_options.api_endpoint is not None:
            api_endpoint = client_options.api_endpoint
        elif use_mtls_endpoint == "always" or (use_mtls_endpoint == "auto" and client_cert_source):
            api_endpoint = cls.DEFAULT_MTLS_ENDPOINT
        else:
            api_endpoint = cls.DEFAULT_ENDPOINT

        return api_endpoint, client_cert_source

    def __init__(self, *,
            credentials: Optional[ga_credentials.Credentials] = None,
            transport: Optional[Union[str, PredictionServiceTransport]] = None,
            client_options: Optional[Union[client_options_lib.ClientOptions, dict]] = None,
            client_info: gapic_v1.client_info.ClientInfo = DEFAULT_CLIENT_INFO,
            ) -> None:
        """Instantiates the prediction service client.

        Args:
            credentials (Optional[google.auth.credentials.Credentials]): The
                authorization credentials to attach to requests. These
                credentials identify the application to the service; if none
                are specified, the client will attempt to ascertain the
                credentials from the environment.
            transport (Union[str, PredictionServiceTransport]): The
                transport to use. If set to None, a transport is chosen
                automatically.
                NOTE: "rest" transport functionality is currently in a
                beta state (preview). We welcome your feedback via an
                issue in this library's source repository.
            client_options (Optional[Union[google.api_core.client_options.ClientOptions, dict]]): Custom options for the
                client. It won't take effect if a ``transport`` instance is provided.
                (1) The ``api_endpoint`` property can be used to override the
                default endpoint provided by the client. GOOGLE_API_USE_MTLS_ENDPOINT
                environment variable can also be used to override the endpoint:
                "always" (always use the default mTLS endpoint), "never" (always
                use the default regular endpoint) and "auto" (auto switch to the
                default mTLS endpoint if client certificate is present, this is
                the default value). However, the ``api_endpoint`` property takes
                precedence if provided.
                (2) If GOOGLE_API_USE_CLIENT_CERTIFICATE environment variable
                is "true", then the ``client_cert_source`` property can be used
                to provide client certificate for mutual TLS transport. If
                not provided, the default SSL client certificate will be used if
                present. If GOOGLE_API_USE_CLIENT_CERTIFICATE is "false" or not
                set, no client certificate will be used.
            client_info (google.api_core.gapic_v1.client_info.ClientInfo):
                The client info used to send a user-agent string along with
                API requests. If ``None``, then default info will be used.
                Generally, you only need to set this if you're developing
                your own client library.

        Raises:
            google.auth.exceptions.MutualTLSChannelError: If mutual TLS transport
                creation failed for any reason.
        """
        if isinstance(client_options, dict):
            client_options = client_options_lib.from_dict(client_options)
        if client_options is None:
            client_options = client_options_lib.ClientOptions()
        client_options = cast(client_options_lib.ClientOptions, client_options)

        api_endpoint, client_cert_source_func = self.get_mtls_endpoint_and_cert_source(client_options)

        api_key_value = getattr(client_options, "api_key", None)
        if api_key_value and credentials:
            raise ValueError("client_options.api_key and credentials are mutually exclusive")

        # Save or instantiate the transport.
        # Ordinarily, we provide the transport, but allowing a custom transport
        # instance provides an extensibility point for unusual situations.
        if isinstance(transport, PredictionServiceTransport):
            # transport is a PredictionServiceTransport instance.
            if credentials or client_options.credentials_file or api_key_value:
                raise ValueError("When providing a transport instance, "
                                 "provide its credentials directly.")
            if client_options.scopes:
                raise ValueError(
                    "When providing a transport instance, provide its scopes "
                    "directly."
                )
            self._transport = transport
        else:
            import google.auth._default  # type: ignore

            if api_key_value and hasattr(google.auth._default, "get_api_key_credentials"):
                credentials = google.auth._default.get_api_key_credentials(api_key_value)

            Transport = type(self).get_transport_class(transport)
            self._transport = Transport(
                credentials=credentials,
                credentials_file=client_options.credentials_file,
                host=api_endpoint,
                scopes=client_options.scopes,
                client_cert_source_for_mtls=client_cert_source_func,
                quota_project_id=client_options.quota_project_id,
                client_info=client_info,
                always_use_jwt_access=True,
                api_audience=client_options.api_audience,
            )

    def predict(self,
            request: Optional[Union[prediction_service.PredictRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            instances: Optional[MutableSequence[struct_pb2.Value]] = None,
            parameters: Optional[struct_pb2.Value] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.PredictResponse:
        r"""Perform an online prediction.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                instances = aiplatform_v1beta1.Value()
                instances.null_value = "NULL_VALUE"

                request = aiplatform_v1beta1.PredictRequest(
                    endpoint="endpoint_value",
                    instances=instances,
                )

                # Make the request
                response = client.predict(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.PredictRequest, dict]):
                The request object. Request message for
                [PredictionService.Predict][google.cloud.aiplatform.v1beta1.PredictionService.Predict].
            endpoint (str):
                Required. The name of the Endpoint requested to serve
                the prediction. Format:
                ``projects/{project}/locations/{location}/endpoints/{endpoint}``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            instances (MutableSequence[google.protobuf.struct_pb2.Value]):
                Required. The instances that are the input to the
                prediction call. A DeployedModel may have an upper limit
                on the number of instances it supports per request, and
                when it is exceeded the prediction call errors in case
                of AutoML Models, or, in case of customer created
                Models, the behaviour is as documented by that Model.
                The schema of any single instance may be specified via
                Endpoint's DeployedModels'
                [Model's][google.cloud.aiplatform.v1beta1.DeployedModel.model]
                [PredictSchemata's][google.cloud.aiplatform.v1beta1.Model.predict_schemata]
                [instance_schema_uri][google.cloud.aiplatform.v1beta1.PredictSchemata.instance_schema_uri].

                This corresponds to the ``instances`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            parameters (google.protobuf.struct_pb2.Value):
                The parameters that govern the prediction. The schema of
                the parameters may be specified via Endpoint's
                DeployedModels' [Model's
                ][google.cloud.aiplatform.v1beta1.DeployedModel.model]
                [PredictSchemata's][google.cloud.aiplatform.v1beta1.Model.predict_schemata]
                [parameters_schema_uri][google.cloud.aiplatform.v1beta1.PredictSchemata.parameters_schema_uri].

                This corresponds to the ``parameters`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.PredictResponse:
                Response message for
                   [PredictionService.Predict][google.cloud.aiplatform.v1beta1.PredictionService.Predict].

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, instances, parameters])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.PredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.PredictRequest):
            request = prediction_service.PredictRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if instances is not None:
                request.instances.extend(instances)
            if parameters is not None:
                request.parameters = parameters

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def raw_predict(self,
            request: Optional[Union[prediction_service.RawPredictRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            http_body: Optional[httpbody_pb2.HttpBody] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> httpbody_pb2.HttpBody:
        r"""Perform an online prediction with an arbitrary HTTP payload.

        The response includes the following HTTP headers:

        -  ``X-Vertex-AI-Endpoint-Id``: ID of the
           [Endpoint][google.cloud.aiplatform.v1beta1.Endpoint] that
           served this prediction.

        -  ``X-Vertex-AI-Deployed-Model-Id``: ID of the Endpoint's
           [DeployedModel][google.cloud.aiplatform.v1beta1.DeployedModel]
           that served this prediction.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_raw_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.RawPredictRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                response = client.raw_predict(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.RawPredictRequest, dict]):
                The request object. Request message for
                [PredictionService.RawPredict][google.cloud.aiplatform.v1beta1.PredictionService.RawPredict].
            endpoint (str):
                Required. The name of the Endpoint requested to serve
                the prediction. Format:
                ``projects/{project}/locations/{location}/endpoints/{endpoint}``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            http_body (google.api.httpbody_pb2.HttpBody):
                The prediction input. Supports HTTP headers and
                arbitrary data payload.

                A
                [DeployedModel][google.cloud.aiplatform.v1beta1.DeployedModel]
                may have an upper limit on the number of instances it
                supports per request. When this limit it is exceeded for
                an AutoML model, the
                [RawPredict][google.cloud.aiplatform.v1beta1.PredictionService.RawPredict]
                method returns an error. When this limit is exceeded for
                a custom-trained model, the behavior varies depending on
                the model.

                You can specify the schema for each instance in the
                [predict_schemata.instance_schema_uri][google.cloud.aiplatform.v1beta1.PredictSchemata.instance_schema_uri]
                field when you create a
                [Model][google.cloud.aiplatform.v1beta1.Model]. This
                schema applies when you deploy the ``Model`` as a
                ``DeployedModel`` to an
                [Endpoint][google.cloud.aiplatform.v1beta1.Endpoint] and
                use the ``RawPredict`` method.

                This corresponds to the ``http_body`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            google.api.httpbody_pb2.HttpBody:
                Message that represents an arbitrary HTTP body. It should only be used for
                   payload formats that can't be represented as JSON,
                   such as raw binary or an HTML page.

                   This message can be used both in streaming and
                   non-streaming API methods in the request as well as
                   the response.

                   It can be used as a top-level request field, which is
                   convenient if one wants to extract parameters from
                   either the URL or HTTP template into the request
                   fields and also want access to the raw HTTP body.

                   Example:

                      message GetResourceRequest {
                         // A unique request id. string request_id = 1;

                         // The raw HTTP body is bound to this field.
                         google.api.HttpBody http_body = 2;

                      }

                      service ResourceService {
                         rpc GetResource(GetResourceRequest) returns
                         (google.api.HttpBody); rpc
                         UpdateResource(google.api.HttpBody) returns
                         (google.protobuf.Empty);

                      }

                   Example with streaming methods:

                      service CaldavService {
                         rpc GetCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                         rpc UpdateCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                      }

                   Use of this type only changes how the request and
                   response bodies are handled, all other features will
                   continue to work unchanged.

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, http_body])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.RawPredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.RawPredictRequest):
            request = prediction_service.RawPredictRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if http_body is not None:
                request.http_body = http_body

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.raw_predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def stream_raw_predict(self,
            request: Optional[Union[prediction_service.StreamRawPredictRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            http_body: Optional[httpbody_pb2.HttpBody] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[httpbody_pb2.HttpBody]:
        r"""Perform a streaming online prediction with an
        arbitrary HTTP payload.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_stream_raw_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamRawPredictRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                stream = client.stream_raw_predict(request=request)

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamRawPredictRequest, dict]):
                The request object. Request message for
                [PredictionService.StreamRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamRawPredict].
            endpoint (str):
                Required. The name of the Endpoint requested to serve
                the prediction. Format:
                ``projects/{project}/locations/{location}/endpoints/{endpoint}``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            http_body (google.api.httpbody_pb2.HttpBody):
                The prediction input. Supports HTTP
                headers and arbitrary data payload.

                This corresponds to the ``http_body`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[google.api.httpbody_pb2.HttpBody]:
                Message that represents an arbitrary HTTP body. It should only be used for
                   payload formats that can't be represented as JSON,
                   such as raw binary or an HTML page.

                   This message can be used both in streaming and
                   non-streaming API methods in the request as well as
                   the response.

                   It can be used as a top-level request field, which is
                   convenient if one wants to extract parameters from
                   either the URL or HTTP template into the request
                   fields and also want access to the raw HTTP body.

                   Example:

                      message GetResourceRequest {
                         // A unique request id. string request_id = 1;

                         // The raw HTTP body is bound to this field.
                         google.api.HttpBody http_body = 2;

                      }

                      service ResourceService {
                         rpc GetResource(GetResourceRequest) returns
                         (google.api.HttpBody); rpc
                         UpdateResource(google.api.HttpBody) returns
                         (google.protobuf.Empty);

                      }

                   Example with streaming methods:

                      service CaldavService {
                         rpc GetCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                         rpc UpdateCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                      }

                   Use of this type only changes how the request and
                   response bodies are handled, all other features will
                   continue to work unchanged.

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, http_body])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.StreamRawPredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.StreamRawPredictRequest):
            request = prediction_service.StreamRawPredictRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if http_body is not None:
                request.http_body = http_body

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.stream_raw_predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def direct_predict(self,
            request: Optional[Union[prediction_service.DirectPredictRequest, dict]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.DirectPredictResponse:
        r"""Perform an unary online prediction request to a gRPC
        model server for Vertex first-party products and
        frameworks.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_direct_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.DirectPredictRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                response = client.direct_predict(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.DirectPredictRequest, dict]):
                The request object. Request message for
                [PredictionService.DirectPredict][google.cloud.aiplatform.v1beta1.PredictionService.DirectPredict].
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.DirectPredictResponse:
                Response message for
                   [PredictionService.DirectPredict][google.cloud.aiplatform.v1beta1.PredictionService.DirectPredict].

        """
        # Create or coerce a protobuf request object.
        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.DirectPredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.DirectPredictRequest):
            request = prediction_service.DirectPredictRequest(request)

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.direct_predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def direct_raw_predict(self,
            request: Optional[Union[prediction_service.DirectRawPredictRequest, dict]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.DirectRawPredictResponse:
        r"""Perform an unary online prediction request to a gRPC
        model server for custom containers.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_direct_raw_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.DirectRawPredictRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                response = client.direct_raw_predict(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.DirectRawPredictRequest, dict]):
                The request object. Request message for
                [PredictionService.DirectRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.DirectRawPredict].
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.DirectRawPredictResponse:
                Response message for
                   [PredictionService.DirectRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.DirectRawPredict].

        """
        # Create or coerce a protobuf request object.
        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.DirectRawPredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.DirectRawPredictRequest):
            request = prediction_service.DirectRawPredictRequest(request)

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.direct_raw_predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def stream_direct_predict(self,
            requests: Optional[Iterator[prediction_service.StreamDirectPredictRequest]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.StreamDirectPredictResponse]:
        r"""Perform a streaming online prediction request to a
        gRPC model server for Vertex first-party products and
        frameworks.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_stream_direct_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamDirectPredictRequest(
                    endpoint="endpoint_value",
                )

                # This method expects an iterator which contains
                # 'aiplatform_v1beta1.StreamDirectPredictRequest' objects
                # Here we create a generator that yields a single `request` for
                # demonstrative purposes.
                requests = [request]

                def request_generator():
                    for request in requests:
                        yield request

                # Make the request
                stream = client.stream_direct_predict(requests=request_generator())

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            requests (Iterator[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamDirectPredictRequest]):
                The request object iterator. Request message for
                [PredictionService.StreamDirectPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamDirectPredict].

                The first message must contain
                [endpoint][google.cloud.aiplatform.v1beta1.StreamDirectPredictRequest.endpoint]
                field and optionally [input][]. The subsequent messages
                must contain [input][].
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamDirectPredictResponse]:
                Response message for
                   [PredictionService.StreamDirectPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamDirectPredict].

        """

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.stream_direct_predict]

        # Send the request.
        response = rpc(
            requests,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def stream_direct_raw_predict(self,
            requests: Optional[Iterator[prediction_service.StreamDirectRawPredictRequest]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.StreamDirectRawPredictResponse]:
        r"""Perform a streaming online prediction request to a
        gRPC model server for custom containers.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_stream_direct_raw_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamDirectRawPredictRequest(
                    endpoint="endpoint_value",
                )

                # This method expects an iterator which contains
                # 'aiplatform_v1beta1.StreamDirectRawPredictRequest' objects
                # Here we create a generator that yields a single `request` for
                # demonstrative purposes.
                requests = [request]

                def request_generator():
                    for request in requests:
                        yield request

                # Make the request
                stream = client.stream_direct_raw_predict(requests=request_generator())

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            requests (Iterator[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamDirectRawPredictRequest]):
                The request object iterator. Request message for
                [PredictionService.StreamDirectRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamDirectRawPredict].

                The first message must contain
                [endpoint][google.cloud.aiplatform.v1beta1.StreamDirectRawPredictRequest.endpoint]
                and
                [method_name][google.cloud.aiplatform.v1beta1.StreamDirectRawPredictRequest.method_name]
                fields and optionally
                [input][google.cloud.aiplatform.v1beta1.StreamDirectRawPredictRequest.input].
                The subsequent messages must contain
                [input][google.cloud.aiplatform.v1beta1.StreamDirectRawPredictRequest.input].
                [method_name][google.cloud.aiplatform.v1beta1.StreamDirectRawPredictRequest.method_name]
                in the subsequent messages have no effect.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamDirectRawPredictResponse]:
                Response message for
                   [PredictionService.StreamDirectRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamDirectRawPredict].

        """

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.stream_direct_raw_predict]

        # Send the request.
        response = rpc(
            requests,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def streaming_predict(self,
            requests: Optional[Iterator[prediction_service.StreamingPredictRequest]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.StreamingPredictResponse]:
        r"""Perform a streaming online prediction request for
        Vertex first-party products and frameworks.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_streaming_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamingPredictRequest(
                    endpoint="endpoint_value",
                )

                # This method expects an iterator which contains
                # 'aiplatform_v1beta1.StreamingPredictRequest' objects
                # Here we create a generator that yields a single `request` for
                # demonstrative purposes.
                requests = [request]

                def request_generator():
                    for request in requests:
                        yield request

                # Make the request
                stream = client.streaming_predict(requests=request_generator())

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            requests (Iterator[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingPredictRequest]):
                The request object iterator. Request message for
                [PredictionService.StreamingPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingPredict].

                The first message must contain
                [endpoint][google.cloud.aiplatform.v1beta1.StreamingPredictRequest.endpoint]
                field and optionally [input][]. The subsequent messages
                must contain [input][].
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingPredictResponse]:
                Response message for
                   [PredictionService.StreamingPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingPredict].

        """

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.streaming_predict]

        # Send the request.
        response = rpc(
            requests,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def server_streaming_predict(self,
            request: Optional[Union[prediction_service.StreamingPredictRequest, dict]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.StreamingPredictResponse]:
        r"""Perform a server-side streaming online prediction
        request for Vertex LLM streaming.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_server_streaming_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamingPredictRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                stream = client.server_streaming_predict(request=request)

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingPredictRequest, dict]):
                The request object. Request message for
                [PredictionService.StreamingPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingPredict].

                The first message must contain
                [endpoint][google.cloud.aiplatform.v1beta1.StreamingPredictRequest.endpoint]
                field and optionally [input][]. The subsequent messages
                must contain [input][].
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingPredictResponse]:
                Response message for
                   [PredictionService.StreamingPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingPredict].

        """
        # Create or coerce a protobuf request object.
        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.StreamingPredictRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.StreamingPredictRequest):
            request = prediction_service.StreamingPredictRequest(request)

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.server_streaming_predict]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def streaming_raw_predict(self,
            requests: Optional[Iterator[prediction_service.StreamingRawPredictRequest]] = None,
            *,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.StreamingRawPredictResponse]:
        r"""Perform a streaming online prediction request through
        gRPC.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_streaming_raw_predict():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.StreamingRawPredictRequest(
                    endpoint="endpoint_value",
                )

                # This method expects an iterator which contains
                # 'aiplatform_v1beta1.StreamingRawPredictRequest' objects
                # Here we create a generator that yields a single `request` for
                # demonstrative purposes.
                requests = [request]

                def request_generator():
                    for request in requests:
                        yield request

                # Make the request
                stream = client.streaming_raw_predict(requests=request_generator())

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            requests (Iterator[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingRawPredictRequest]):
                The request object iterator. Request message for
                [PredictionService.StreamingRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingRawPredict].

                The first message must contain
                [endpoint][google.cloud.aiplatform.v1beta1.StreamingRawPredictRequest.endpoint]
                and
                [method_name][google.cloud.aiplatform.v1beta1.StreamingRawPredictRequest.method_name]
                fields and optionally
                [input][google.cloud.aiplatform.v1beta1.StreamingRawPredictRequest.input].
                The subsequent messages must contain
                [input][google.cloud.aiplatform.v1beta1.StreamingRawPredictRequest.input].
                [method_name][google.cloud.aiplatform.v1beta1.StreamingRawPredictRequest.method_name]
                in the subsequent messages have no effect.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.StreamingRawPredictResponse]:
                Response message for
                   [PredictionService.StreamingRawPredict][google.cloud.aiplatform.v1beta1.PredictionService.StreamingRawPredict].

        """

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.streaming_raw_predict]

        # Send the request.
        response = rpc(
            requests,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def explain(self,
            request: Optional[Union[prediction_service.ExplainRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            instances: Optional[MutableSequence[struct_pb2.Value]] = None,
            parameters: Optional[struct_pb2.Value] = None,
            deployed_model_id: Optional[str] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.ExplainResponse:
        r"""Perform an online explanation.

        If
        [deployed_model_id][google.cloud.aiplatform.v1beta1.ExplainRequest.deployed_model_id]
        is specified, the corresponding DeployModel must have
        [explanation_spec][google.cloud.aiplatform.v1beta1.DeployedModel.explanation_spec]
        populated. If
        [deployed_model_id][google.cloud.aiplatform.v1beta1.ExplainRequest.deployed_model_id]
        is not specified, all DeployedModels must have
        [explanation_spec][google.cloud.aiplatform.v1beta1.DeployedModel.explanation_spec]
        populated.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_explain():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                instances = aiplatform_v1beta1.Value()
                instances.null_value = "NULL_VALUE"

                request = aiplatform_v1beta1.ExplainRequest(
                    endpoint="endpoint_value",
                    instances=instances,
                )

                # Make the request
                response = client.explain(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.ExplainRequest, dict]):
                The request object. Request message for
                [PredictionService.Explain][google.cloud.aiplatform.v1beta1.PredictionService.Explain].
            endpoint (str):
                Required. The name of the Endpoint requested to serve
                the explanation. Format:
                ``projects/{project}/locations/{location}/endpoints/{endpoint}``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            instances (MutableSequence[google.protobuf.struct_pb2.Value]):
                Required. The instances that are the input to the
                explanation call. A DeployedModel may have an upper
                limit on the number of instances it supports per
                request, and when it is exceeded the explanation call
                errors in case of AutoML Models, or, in case of customer
                created Models, the behaviour is as documented by that
                Model. The schema of any single instance may be
                specified via Endpoint's DeployedModels'
                [Model's][google.cloud.aiplatform.v1beta1.DeployedModel.model]
                [PredictSchemata's][google.cloud.aiplatform.v1beta1.Model.predict_schemata]
                [instance_schema_uri][google.cloud.aiplatform.v1beta1.PredictSchemata.instance_schema_uri].

                This corresponds to the ``instances`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            parameters (google.protobuf.struct_pb2.Value):
                The parameters that govern the prediction. The schema of
                the parameters may be specified via Endpoint's
                DeployedModels' [Model's
                ][google.cloud.aiplatform.v1beta1.DeployedModel.model]
                [PredictSchemata's][google.cloud.aiplatform.v1beta1.Model.predict_schemata]
                [parameters_schema_uri][google.cloud.aiplatform.v1beta1.PredictSchemata.parameters_schema_uri].

                This corresponds to the ``parameters`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            deployed_model_id (str):
                If specified, this ExplainRequest will be served by the
                chosen DeployedModel, overriding
                [Endpoint.traffic_split][google.cloud.aiplatform.v1beta1.Endpoint.traffic_split].

                This corresponds to the ``deployed_model_id`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.ExplainResponse:
                Response message for
                   [PredictionService.Explain][google.cloud.aiplatform.v1beta1.PredictionService.Explain].

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, instances, parameters, deployed_model_id])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.ExplainRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.ExplainRequest):
            request = prediction_service.ExplainRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if instances is not None:
                request.instances.extend(instances)
            if parameters is not None:
                request.parameters = parameters
            if deployed_model_id is not None:
                request.deployed_model_id = deployed_model_id

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.explain]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def count_tokens(self,
            request: Optional[Union[prediction_service.CountTokensRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            instances: Optional[MutableSequence[struct_pb2.Value]] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.CountTokensResponse:
        r"""Perform a token counting.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_count_tokens():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                instances = aiplatform_v1beta1.Value()
                instances.null_value = "NULL_VALUE"

                contents = aiplatform_v1beta1.Content()
                contents.parts.text = "text_value"

                request = aiplatform_v1beta1.CountTokensRequest(
                    endpoint="endpoint_value",
                    model="model_value",
                    instances=instances,
                    contents=contents,
                )

                # Make the request
                response = client.count_tokens(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.CountTokensRequest, dict]):
                The request object. Request message for
                [PredictionService.CountTokens][google.cloud.aiplatform.v1beta1.PredictionService.CountTokens].
            endpoint (str):
                Required. The name of the Endpoint requested to perform
                token counting. Format:
                ``projects/{project}/locations/{location}/endpoints/{endpoint}``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            instances (MutableSequence[google.protobuf.struct_pb2.Value]):
                Required. The instances that are the
                input to token counting call. Schema is
                identical to the prediction schema of
                the underlying model.

                This corresponds to the ``instances`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.CountTokensResponse:
                Response message for
                   [PredictionService.CountTokens][google.cloud.aiplatform.v1beta1.PredictionService.CountTokens].

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, instances])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.CountTokensRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.CountTokensRequest):
            request = prediction_service.CountTokensRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if instances is not None:
                request.instances.extend(instances)

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.count_tokens]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def generate_content(self,
            request: Optional[Union[prediction_service.GenerateContentRequest, dict]] = None,
            *,
            model: Optional[str] = None,
            contents: Optional[MutableSequence[content.Content]] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> prediction_service.GenerateContentResponse:
        r"""Generate content with multimodal inputs.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_generate_content():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                contents = aiplatform_v1beta1.Content()
                contents.parts.text = "text_value"

                request = aiplatform_v1beta1.GenerateContentRequest(
                    model="model_value",
                    contents=contents,
                )

                # Make the request
                response = client.generate_content(request=request)

                # Handle the response
                print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.GenerateContentRequest, dict]):
                The request object. Request message for [PredictionService.GenerateContent].
            model (str):
                Required. The name of the publisher model requested to
                serve the prediction. Format:
                ``projects/{project}/locations/{location}/publishers/*/models/*``

                This corresponds to the ``model`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            contents (MutableSequence[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.Content]):
                Required. The content of the current
                conversation with the model.
                For single-turn queries, this is a
                single instance. For multi-turn queries,
                this is a repeated field that contains
                conversation history + latest request.

                This corresponds to the ``contents`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.GenerateContentResponse:
                Response message for
                [PredictionService.GenerateContent].

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([model, contents])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.GenerateContentRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.GenerateContentRequest):
            request = prediction_service.GenerateContentRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if model is not None:
                request.model = model
            if contents is not None:
                request.contents = contents

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.generate_content]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("model", request.model),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def stream_generate_content(self,
            request: Optional[Union[prediction_service.GenerateContentRequest, dict]] = None,
            *,
            model: Optional[str] = None,
            contents: Optional[MutableSequence[content.Content]] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[prediction_service.GenerateContentResponse]:
        r"""Generate content with multimodal inputs with
        streaming support.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_stream_generate_content():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                contents = aiplatform_v1beta1.Content()
                contents.parts.text = "text_value"

                request = aiplatform_v1beta1.GenerateContentRequest(
                    model="model_value",
                    contents=contents,
                )

                # Make the request
                stream = client.stream_generate_content(request=request)

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.GenerateContentRequest, dict]):
                The request object. Request message for [PredictionService.GenerateContent].
            model (str):
                Required. The name of the publisher model requested to
                serve the prediction. Format:
                ``projects/{project}/locations/{location}/publishers/*/models/*``

                This corresponds to the ``model`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            contents (MutableSequence[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.Content]):
                Required. The content of the current
                conversation with the model.
                For single-turn queries, this is a
                single instance. For multi-turn queries,
                this is a repeated field that contains
                conversation history + latest request.

                This corresponds to the ``contents`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.GenerateContentResponse]:
                Response message for
                [PredictionService.GenerateContent].

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([model, contents])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.GenerateContentRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.GenerateContentRequest):
            request = prediction_service.GenerateContentRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if model is not None:
                request.model = model
            if contents is not None:
                request.contents = contents

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.stream_generate_content]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("model", request.model),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def chat_completions(self,
            request: Optional[Union[prediction_service.ChatCompletionsRequest, dict]] = None,
            *,
            endpoint: Optional[str] = None,
            http_body: Optional[httpbody_pb2.HttpBody] = None,
            retry: OptionalRetry = gapic_v1.method.DEFAULT,
            timeout: Union[float, object] = gapic_v1.method.DEFAULT,
            metadata: Sequence[Tuple[str, str]] = (),
            ) -> Iterable[httpbody_pb2.HttpBody]:
        r"""Exposes an OpenAI-compatible endpoint for chat
        completions.

        .. code-block:: python

            # This snippet has been automatically generated and should be regarded as a
            # code template only.
            # It will require modifications to work:
            # - It may require correct/in-range values for request initialization.
            # - It may require specifying regional endpoints when creating the service
            #   client as shown in:
            #   https://googleapis.dev/python/google-api-core/latest/client_options.html
            from googlecloudsdk.generated_clients.gapic_clients import aiplatform_v1beta1

            def sample_chat_completions():
                # Create a client
                client = aiplatform_v1beta1.PredictionServiceClient()

                # Initialize request argument(s)
                request = aiplatform_v1beta1.ChatCompletionsRequest(
                    endpoint="endpoint_value",
                )

                # Make the request
                stream = client.chat_completions(request=request)

                # Handle the response
                for response in stream:
                    print(response)

        Args:
            request (Union[googlecloudsdk.generated_clients.gapic_clients.aiplatform_v1beta1.types.ChatCompletionsRequest, dict]):
                The request object. Request message for [PredictionService.ChatCompletions]
            endpoint (str):
                Required. The name of the Endpoint requested to serve
                the prediction. Format:
                ``projects/{project}/locations/{location}/endpoints/openapi``

                This corresponds to the ``endpoint`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            http_body (google.api.httpbody_pb2.HttpBody):
                Optional. The prediction input.
                Supports HTTP headers and arbitrary data
                payload.

                This corresponds to the ``http_body`` field
                on the ``request`` instance; if ``request`` is provided, this
                should not be set.
            retry (google.api_core.retry.Retry): Designation of what errors, if any,
                should be retried.
            timeout (float): The timeout for this request.
            metadata (Sequence[Tuple[str, str]]): Strings which should be
                sent along with the request as metadata.

        Returns:
            Iterable[google.api.httpbody_pb2.HttpBody]:
                Message that represents an arbitrary HTTP body. It should only be used for
                   payload formats that can't be represented as JSON,
                   such as raw binary or an HTML page.

                   This message can be used both in streaming and
                   non-streaming API methods in the request as well as
                   the response.

                   It can be used as a top-level request field, which is
                   convenient if one wants to extract parameters from
                   either the URL or HTTP template into the request
                   fields and also want access to the raw HTTP body.

                   Example:

                      message GetResourceRequest {
                         // A unique request id. string request_id = 1;

                         // The raw HTTP body is bound to this field.
                         google.api.HttpBody http_body = 2;

                      }

                      service ResourceService {
                         rpc GetResource(GetResourceRequest) returns
                         (google.api.HttpBody); rpc
                         UpdateResource(google.api.HttpBody) returns
                         (google.protobuf.Empty);

                      }

                   Example with streaming methods:

                      service CaldavService {
                         rpc GetCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                         rpc UpdateCalendar(stream google.api.HttpBody)
                            returns (stream google.api.HttpBody);

                      }

                   Use of this type only changes how the request and
                   response bodies are handled, all other features will
                   continue to work unchanged.

        """
        # Create or coerce a protobuf request object.
        # Quick check: If we got a request object, we should *not* have
        # gotten any keyword arguments that map to the request.
        has_flattened_params = any([endpoint, http_body])
        if request is not None and has_flattened_params:
            raise ValueError('If the `request` argument is set, then none of '
                             'the individual field arguments should be set.')

        # Minor optimization to avoid making a copy if the user passes
        # in a prediction_service.ChatCompletionsRequest.
        # There's no risk of modifying the input as we've already verified
        # there are no flattened fields.
        if not isinstance(request, prediction_service.ChatCompletionsRequest):
            request = prediction_service.ChatCompletionsRequest(request)
            # If we have keyword arguments corresponding to fields on the
            # request, apply these.
            if endpoint is not None:
                request.endpoint = endpoint
            if http_body is not None:
                request.http_body = http_body

        # Wrap the RPC method; this adds retry and timeout information,
        # and friendly error handling.
        rpc = self._transport._wrapped_methods[self._transport.chat_completions]

         # Certain fields should be provided within the metadata header;
        # add these here.
        metadata = tuple(metadata) + (
            gapic_v1.routing_header.to_grpc_metadata((
                ("endpoint", request.endpoint),
            )),
        )

        # Send the request.
        response = rpc(
            request,
            retry=retry,
            timeout=timeout,
            metadata=metadata,
        )

        # Done; return the response.
        return response

    def __enter__(self) -> "PredictionServiceClient":
        return self

    def __exit__(self, type, value, traceback):
        """Releases underlying transport's resources.

        .. warning::
            ONLY use as a context manager if the transport is NOT shared
            with other clients! Exiting the with block will CLOSE the transport
            and may cause errors in other clients!
        """
        self.transport.close()







DEFAULT_CLIENT_INFO = gapic_v1.client_info.ClientInfo(gapic_version=package_version.__version__)


__all__ = (
    "PredictionServiceClient",
)
