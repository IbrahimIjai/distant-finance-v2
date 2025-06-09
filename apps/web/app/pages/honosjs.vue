<template>
  <div class="p-6 max-w-4xl mx-auto space-y-8">
    <div class="text-center">
      <h1 class="text-3xl font-bold text-gray-900 dark:text-white mb-2">
        Hono API Tester
      </h1>
      <p class="text-gray-600 dark:text-gray-400">
        Test your Hono.js API endpoints with useFetch & useAsyncData
      </p>
    </div>

    <!-- API Status -->
    <UCard>
      <template #header>
        <h2 class="text-xl font-semibold">API Connection</h2>
      </template>

      <div class="flex items-center justify-between">
        <div class="flex items-center space-x-2">
          <UBadge
            :color="connectionStatus.success ? 'green' : 'red'"
            variant="subtle"
          >
            {{ connectionStatus.success ? "Connected" : "Disconnected" }}
          </UBadge>
          <span class="text-sm text-gray-600 dark:text-gray-400">
            {{ apiUrl }}
          </span>
        </div>
        <UButton @click="testConnection" :loading="connectionPending">
          Test Connection
        </UButton>
      </div>

      <div v-if="connectionError" class="mt-4">
        <UAlert color="red" :title="connectionError.message" />
      </div>
    </UCard>

    <!-- GET Users Section -->
    <UCard>
      <template #header>
        <div class="flex justify-between items-center">
          <h2 class="text-xl font-semibold">GET Users</h2>
          <UBadge v-if="usersData" color="blue" variant="subtle">
            {{ usersData.length }} users
          </UBadge>
        </div>
      </template>

      <div class="space-y-4">
        <div class="flex space-x-2">
          <UButton @click="refreshUsers" :loading="usersPending">
            {{ usersData ? "Refresh Users" : "Fetch Users" }}
          </UButton>
          <UInput
            v-model="selectedUserId"
            placeholder="User ID"
            class="w-32"
            type="number"
          />
          <UButton
            @click="fetchSingleUser"
            :loading="singleUserPending"
            variant="outline"
          >
            Fetch Single User
          </UButton>
        </div>

        <!-- Users List -->
        <div v-if="usersData && usersData.length > 0" class="space-y-2">
          <h3 class="font-semibold">All Users:</h3>
          <div class="grid gap-2">
            <UCard v-for="user in usersData" :key="user.id" class="p-3">
              <div class="flex justify-between items-center">
                <div>
                  <p class="font-medium">{{ user.name }}</p>
                  <p class="text-sm text-gray-600 dark:text-gray-400">
                    {{ user.email }}
                  </p>
                </div>
                <UBadge variant="subtle">ID: {{ user.id }}</UBadge>
              </div>
            </UCard>
          </div>
        </div>

        <!-- Single User Display -->
        <div v-if="singleUserData" class="space-y-2">
          <h3 class="font-semibold">Single User Result:</h3>
          <UCard class="p-3">
            <div class="flex justify-between items-center">
              <div>
                <p class="font-medium">{{ singleUserData.name }}</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">
                  {{ singleUserData.email }}
                </p>
              </div>
              <UBadge variant="subtle">ID: {{ singleUserData.id }}</UBadge>
            </div>
          </UCard>
        </div>

        <!-- Error States -->
        <div v-if="usersError" class="mt-4">
          <UAlert
            color="red"
            title="Error fetching users"
            :description="usersError.message"
          />
        </div>
        <div v-if="singleUserError" class="mt-4">
          <UAlert
            color="red"
            title="Error fetching user"
            :description="singleUserError.message"
          />
        </div>
      </div>
    </UCard>

    <!-- POST User Section -->
    <UCard>
      <template #header>
        <h2 class="text-xl font-semibold">POST New User</h2>
      </template>

      <UForm :state="newUser" @submit="createUser" class="space-y-4">
        <UFormGroup label="Name" name="name" required>
          <UInput v-model="newUser.name" placeholder="Enter user name" />
        </UFormGroup>

        <UFormGroup label="Email" name="email" required>
          <UInput
            v-model="newUser.email"
            type="email"
            placeholder="Enter email"
          />
        </UFormGroup>

        <UButton
          type="submit"
          :loading="creatingUser"
          :disabled="!newUser.name || !newUser.email"
        >
          Create User
        </UButton>
      </UForm>

      <div v-if="createUserError" class="mt-4">
        <UAlert
          color="red"
          title="Error creating user"
          :description="createUserError"
        />
      </div>
    </UCard>

    <!-- Async Data Status -->
    <UCard>
      <template #header>
        <h2 class="text-xl font-semibold">Data Status</h2>
      </template>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="space-y-2">
          <h3 class="font-medium">Connection Status</h3>
          <div class="flex items-center space-x-2">
            <UBadge
              :color="
                connectionPending ? 'yellow' : connectionError ? 'red' : 'green'
              "
              variant="subtle"
            >
              {{
                connectionPending
                  ? "Loading..."
                  : connectionError
                    ? "Error"
                    : "Ready"
              }}
            </UBadge>
          </div>
        </div>

        <div class="space-y-2">
          <h3 class="font-medium">Users Data</h3>
          <div class="flex items-center space-x-2">
            <UBadge
              :color="usersPending ? 'yellow' : usersError ? 'red' : 'green'"
              variant="subtle"
            >
              {{ usersPending ? "Loading..." : usersError ? "Error" : "Ready" }}
            </UBadge>
          </div>
        </div>

        <div class="space-y-2">
          <h3 class="font-medium">Single User</h3>
          <div class="flex items-center space-x-2">
            <UBadge
              :color="
                singleUserPending ? 'yellow' : singleUserError ? 'red' : 'green'
              "
              variant="subtle"
            >
              {{
                singleUserPending
                  ? "Loading..."
                  : singleUserError
                    ? "Error"
                    : "Ready"
              }}
            </UBadge>
          </div>
        </div>
      </div>
    </UCard>

    <!-- Raw Response Display -->
    <UCard v-if="showRawResponse">
      <template #header>
        <div class="flex justify-between items-center">
          <h2 class="text-xl font-semibold">Raw Responses</h2>
          <UButton
            @click="showRawResponse = !showRawResponse"
            variant="ghost"
            size="sm"
          >
            {{ showRawResponse ? "Hide" : "Show" }}
          </UButton>
        </div>
      </template>

      <div class="space-y-4">
        <div v-if="usersResponse">
          <h3 class="font-medium mb-2">Users Response:</h3>
          <pre
            class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg text-sm overflow-auto"
            >{{ JSON.stringify(usersResponse, null, 2) }}</pre
          >
        </div>

        <div v-if="singleUserResponse">
          <h3 class="font-medium mb-2">Single User Response:</h3>
          <pre
            class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg text-sm overflow-auto"
            >{{ JSON.stringify(singleUserResponse, null, 2) }}</pre
          >
        </div>
      </div>
    </UCard>

    <!-- Toggle Raw Response -->
    <div class="flex justify-center">
      <UButton @click="showRawResponse = !showRawResponse" variant="outline">
        {{ showRawResponse ? "Hide" : "Show" }} Raw Responses
      </UButton>
    </div>
  </div>
</template>

<script setup>
import { toast } from "vue-sonner";
const config = useRuntimeConfig();

// Reactive state
const selectedUserId = ref("");
const showRawResponse = ref(false);
const creatingUser = ref(false);
const createUserError = ref("");

const newUser = ref({
  name: "",
  email: "",
});

// Connection test using useAsyncData
const {
  data: connectionData,
  pending: connectionPending,
  error: connectionError,
  refresh: testConnection,
} = await useAsyncData(
  "api-connection",
  () => $fetch(`${config.public.offchainworkerApiUrl}/`),
  {
    server: false, // Client-side only since it's an external API
    default: () => null,
  }
);

const connectionStatus = computed(() => ({
  success: connectionData.value !== null && !connectionError.value,
}));

// Fetch all users using useFetch
const {
  data: usersResponse,
  pending: usersPending,
  error: usersError,
  refresh: refreshUsers,
} = await useFetch(`${config.public.offchainworkerApiUrl}/users`, {
  server: false, // Client-side only
  default: () => ({ data: [], success: false }),
});

// Computed property to extract users data
const usersData = computed(() => {
  return usersResponse.value?.data || [];
});

// Single user fetch using useAsyncData with dynamic key
const {
  data: singleUserResponse,
  pending: singleUserPending,
  error: singleUserError,
  refresh: refreshSingleUser,
} = await useAsyncData("single-user", () => null, {
  server: false,
  default: () => null,
});

const singleUserData = computed(() => {
  return singleUserResponse.value?.data || null;
});

// Fetch single user function
const fetchSingleUser = async () => {
  if (!selectedUserId.value) {
    toast.error("Please enter a user ID");
    return;
  }

  try {
    const { data, error } = await useAsyncData(
      `single-user-${selectedUserId.value}`,
      () => $fetch(`${config.public.offchainworkerApiUrl}/users/${selectedUserId.value}`),
      {
        server: false,
      }
    );

    if (error.value) {
      throw error.value;
    }

    singleUserResponse.value = data.value;
    toast.success("User fetched successfully!");
  } catch (err) {
    toast.error("Failed to fetch user");
    console.error("Fetch user error:", err);
  }
};

// Create new user using $fetch (since useFetch is mainly for GET requests)
const createUser = async () => {
  if (!newUser.value.name || !newUser.value.email) {
    createUserError.value = "Please fill in all fields";
    toast.error("Please fill in all fields");
    return;
  }

  creatingUser.value = true;
  createUserError.value = "";

  try {
    const response = await $fetch(`${config.public.offchainworkerApiUrl}/users`, {
      method: "POST",
      body: JSON.stringify(newUser.value),
      headers: {
        "Content-Type": "application/json",
      },
    });

    toast.success("User created successfully!");

    // Reset form
    newUser.value = { name: "", email: "" };

    // Refresh users list
    await refreshUsers();
  } catch (error) {
    createUserError.value =
      error.data?.message || error.message || "Failed to create user";
    toast.error(error.data?.message || "Failed to create user");
  } finally {
    creatingUser.value = false;
  }
};

// Notification system
const showToast = ref(false);
const toastMessage = ref("");
const toastType = ref("success");

const showNotification = (message, type = "success") => {
  toastMessage.value = message;
  toastType.value = type;
  showToast.value = true;

  setTimeout(() => {
    showToast.value = false;
  }, 3000);
};

// Watch for connection status changes
watch(connectionStatus, (newStatus) => {
  if (newStatus.success) {
    showNotification("API connected successfully!", "success");
  }
});

// Watch for users data changes
watch(usersData, (newUsers) => {
  if (newUsers && newUsers.length > 0) {
    showNotification(`Loaded ${newUsers.length} users`, "success");
  }
});
</script>
