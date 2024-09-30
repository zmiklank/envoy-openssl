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
    tools = [
        "//bssl-compat/prefixer:prefixer",
    ],
    outs = [
        "source/ossl.c",
        "include/ossl.h",
        "include/ossl/openssl/err.h",
    ],
    cmd = """ \
      LD_LIBRARY_PATH=/opt/llvm/lib/ \
      bazel-out/k8-fastbuild/bin/bssl-compat/prefixer/prefixer \
      --src-path /usr/include/ \
      --src-incl \"openssl/*.h\" \
      --src-skip openssl/asn1_mac.h \
      --src-skip \"openssl/opensslconf-*.h\" \
      --verbose \
      --output $(RULEDIR) \
      --prefix ossl \
      """,
)
      #$(locations //bssl-compat/prefixer:prefixer)


genrule(
    name = "bssl_gen_headers",
    tools = [
        "//bssl-compat:tools/uncomment.sh",
        "//bssl-compat:tools/generate.h.sh",
    ],
    srcs = glob([
      "third_party/boringssl/src/include/openssl/*.h",
      "patch/**",
      ]),
    outs = [
      "include/openssl/aead.h",
      "include/openssl/aes.h",
      "include/openssl/arm_arch.h",
      "include/openssl/asn1.h",
      "include/openssl/asn1_mac.h",
      "include/openssl/asn1t.h",
      "include/openssl/base64.h",
      "include/openssl/base.h",
      "include/openssl/bio.h",
      "include/openssl/blake2.h",
      "include/openssl/blowfish.h",
      "include/openssl/bn.h",
      "include/openssl/buffer.h",
      "include/openssl/buf.h",
      "include/openssl/bytestring.h",
      "include/openssl/cast.h",
      "include/openssl/chacha.h",
      "include/openssl/cipher.h",
      "include/openssl/cmac.h",
      "include/openssl/conf.h",
      "include/openssl/cpu.h",
      "include/openssl/crypto.h",
      "include/openssl/curve25519.h",
      "include/openssl/des.h",
      "include/openssl/dh.h",
      "include/openssl/digest.h",
      "include/openssl/dsa.h",
      "include/openssl/dtls1.h",
      "include/openssl/ecdh.h",
      "include/openssl/ecdsa.h",
      "include/openssl/ec.h",
      "include/openssl/ec_key.h",
      "include/openssl/engine.h",
      "include/openssl/e_os2.h",
      "include/openssl/err.h",
      "include/openssl/evp_errors.h",
      "include/openssl/evp.h",
      "include/openssl/ex_data.h",
      "include/openssl/hkdf.h",
      "include/openssl/hmac.h",
      "include/openssl/hpke.h",
      "include/openssl/hrss.h",
      "include/openssl/is_boringssl.h",
      "include/openssl/kdf.h",
      "include/openssl/lhash.h",
      "include/openssl/md4.h",
      "include/openssl/md5.h",
      "include/openssl/mem.h",
      "include/openssl/nid.h",
      "include/openssl/objects.h",
      ],
    cmd = """
      #!/bin/bash
      for header in $(SRCS); do
        if [[ "$$header" != "*/patch/*" ]]; then
          $(location tools/generate.h.sh) $(location tools/uncomment.sh) $$header "./include/openssl/$${header##*/}" $(RULEDIR)
        fi
      done
      """, # TODO: the condition in cmd does not work
    visibility = ["//visibility:public"],
)

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

