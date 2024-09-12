# load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")
# 
# filegroup(
#     name = "srcs",
#     srcs = glob(["**"]),
# )
# 
# licenses(["notice"])  # Apache 2
# 
# cmake(
#     name = "bssl-compat",
#     lib_source = ":srcs",
#     out_shared_libs = [],
#     out_static_libs = ["libbssl-compat.a"],
#     visibility = ["//visibility:public"],
#     generate_crosstool_file = False,
#     env = { "Clang_ROOT" : "/usr/lib/llvm" },
# 
#     build_args = [ "-j" ]
# )
# 

load(
    "//bazel:envoy_build_system.bzl",
    "envoy_cc_library",
    "envoy_package",
)

envoy_package()

genrule(
    name = "ossl_gen",
    srcs = [
        "//bssl-compat/prefixer:prefixer",
        "@clang//:clang_lib"
    ],
    outs = [
        "source/ossl.c",
        "include/ossl.h",
        "include/ossl/openssl/err.h",
    ],
    cmd = """ \
      LD_LIBRARY_PATH=/opt/llvm/lib/ \
      bazel-out/k8-fastbuild/bin/bssl-compat/prefixer/prefixer \
      --src-path /usr/include/openssl/ \
      --src-incl \"openssl/*.h\" \
      --src-skip openssl/asn1_mac.h \
      --src-skip \"openssl/opensslconf-*.h\" \
      --verbose \
      --output . \
      --prefix include/ossl/openssl \
      """,
    tools = ["//bssl-compat/prefixer:prefixer"],
)
      #$(locations //bssl-compat/prefixer:prefixer)

# Generate bssl files which depend on ossl files
#genrule(
#    name = "bssl_gen",
#    outs = [
#        "include/ossl.h",
#    ],
#    deps = [
#    "//bssl-compat:ossl_gen",
#    ],
#    cmd = "touch .",  # Replace this with the actual command to generate bssl files
#)

cc_library(
	name = "bssl-compat",
  linkstatic = True,
	srcs = [
      "source/ASN1_TIME_free.cc",
      "source/BASIC_CONSTRAINTS_free.cc",
      "source/BASIC_CONSTRAINTS_new.cc",
      "source/bio_meth_map.cpp",
      "source/BIO_free.cc",
      "source/BIO_mem_contents.cc",
      "source/BIO_new_bio_pair.cc",
      "source/BIO_new.cc",
      "source/BIO_pending.cc",
      "source/BIO_printf.cc",
      "source/BIO_read_asn1.c",
      "source/BIO_s_mem.cc",
      "source/BIO_s_socket.cc",
      "source/BIO_snprintf.cc",
      "source/BIO_vfree.cc",
      "source/BN_cmp_word.cc",
      "source/BN_bn2hex.cc",
      "source/BN_bin2bn.cc",
      "source/c2i_ASN1_INTEGER.cc",
      "source/CRYPTO_BUFFER_free.c",
      "source/CRYPTO_BUFFER.h",
      "source/CRYPTO_BUFFER_new.c",
      "source/d2i_GENERAL_NAME.cc",
      "source/ECDSA_do_verify.cc",
      "source/ECDSA_sign.cc",
      "source/EC_KEY_check_fips.cc",
      "source/EC_KEY_parse_private_key.cc",
      "source/EC_KEY_set_public_key_affine_coordinate.cc",
      "source/ED25519_verify.cc",
      "source/err.cc",
      "source/EVP_DecodeBase64.c",
      "source/EVP_DecodedLength.c",
      "source/EVP_DigestVerifyFinal.cc",
      "source/EVP_DigestSignFinal.cc",
      "source/EVP_MD_CTX_move.cc",
      "source/EVP_parse_public_key.cc",
      "source/EVP_PKEY_get0_EC_KEY.cc",
      "source/EVP_PKEY_get0_RSA.cc",
      "source/EVP_PKEY_get1_EC_KEY.cc",
      "source/EVP_PKEY_get1_RSA.cc",
      "source/EVP_PKEY_id.cc",
      "source/ext_SSL_get_all_async_fds.c",
      "source/FIPS_mode.cc",
      "source/GENERAL_NAME_free.cc",
      "source/GENERAL_NAME_new.cc",
      "source/GENERAL_NAMES_free.cc",
      "source/GENERAL_NAMES_new.cc",
      "source/GENERAL_SUBTREE_free.cc",
      "source/GENERAL_SUBTREE_new.cc",
      "source/HMAC_Init_ex.cc",
      "source/i2d_X509.c",
      "source/i2d_X509_PUBKEY.cc",
      "source/iana_2_ossl_names.cc",
      "source/internal.h",
      "source/log.c",
      "source/log.h",
      "source/NAME_CONSTRAINTS_free.cc",
      "source/NAME_CONSTRAINTS_new.cc",
      "source/ossl.c",
      "source/override.h",
      "source/override.cc",
      "source/PEM_read_bio_PrivateKey.cc",
      "source/PEM_read_bio_RSAPrivateKey.c",
      "source/PEM_read_bio_X509.cc",
      "source/PEM_read_bio_X509_AUX.cc",
      "source/PEM_read_bio_X509_CRL.cc",
      "source/PEM_read_bio_PUBKEY.cc",
      "source/PEM_write_bio_X509.cc",
      "source/PEM_X509_INFO_read_bio.cc",
      "source/PKCS12_get_key_and_certs.cc",
      "source/PKCS12_parse.cc",
      "source/PKCS12_verify_mac.cc",
	],
	hdrs = [],
	deps = [
    "//bssl-compat:ossl_gen",
    "@openssl//:openssl-lib",
      ],
)
alias(
    name = "crypto",
    actual = ":bssl-compat",
    visibility = ["//visibility:public"],
)

alias(
    name = "ssl",
    actual = ":bssl-compat",
    visibility = ["//visibility:public"],
)

